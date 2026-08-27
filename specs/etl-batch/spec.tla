---- MODULE spec ----
(*
학습 목적: etl-batch의 step-functions 모듈은 상태 머신 정의(JSON)를 만들 뿐,
그 상태 머신이 실행될 때 재시도(retry) 로직이 실제로 어떻게 동작하는지는
Terraform 코드에 없다 — Step Functions의 Retry 필드가 보장하는 "실패해도
최대 횟수까지는 자동 재시도하고, 그래도 안 되면 Fail로 확정한다"는 동작을
여기서 명세한다.

핵심 안전 속성: 재시도 횟수(attempts)는 설정된 최대치(MaxRetries)를 절대
넘지 않으며, Succeeded와 Failed는 동시에 성립할 수 없는 배타적 최종 상태다.
*)
EXTENDS Naturals

CONSTANTS MaxRetries

VARIABLES state, attempts

vars == <<state, attempts>>

States == {"Running", "Succeeded", "Failed"}

Init ==
    /\ state = "Running"
    /\ attempts = 0

\* Glue 작업이 성공적으로 끝나면 상태 머신은 Succeeded로 확정된다(최종 상태).
TaskSucceeds ==
    /\ state = "Running"
    /\ state' = "Succeeded"
    /\ UNCHANGED attempts

\* Glue 작업이 실패했지만 아직 재시도 여력이 있으면, Step Functions의 Retry
\* 필드가 자동으로 다시 Running 상태로 되돌린다(attempts만 증가).
TaskFailsWithRetry ==
    /\ state = "Running"
    /\ attempts < MaxRetries
    /\ attempts' = attempts + 1
    /\ UNCHANGED state

\* 재시도 횟수를 다 소진한 뒤에도 실패하면 그때야 비로소 Failed로 확정된다
\* (Step Functions의 "재시도 소진 후 확정 실패" 동작).
TaskFailsExhausted ==
    /\ state = "Running"
    /\ attempts = MaxRetries
    /\ state' = "Failed"
    /\ UNCHANGED attempts

Next == TaskSucceeds \/ TaskFailsWithRetry \/ TaskFailsExhausted

Spec == Init /\ [][Next]_vars

TypeInvariant ==
    /\ state \in States
    /\ attempts \in 0..MaxRetries

BoundedRetries == attempts <= MaxRetries

====
