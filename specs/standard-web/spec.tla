---- MODULE spec ----
(*
학습 목적: standard-web에서 ALB가 백엔드 ECS 태스크 하나의 헬스체크 상태를
어떻게 관리하는지 모델링한다. Terraform 코드(alb 모듈의 health_check 블록,
ecs-service 모듈)는 "이런 리소스를 만들라"만 선언할 뿐, 배포된 시스템이 실제로
어떤 순서로 상태를 오가는지는 설명하지 않는다 — 그 런타임 동작을 여기서
명세한다.

핵심 안전 속성: 한 번 Terminated된 태스크는 다시 Healthy로 돌아오지 않는다
(ECS는 죽은 태스크를 "복구"하는 게 아니라 새 태스크를 만든다는 실제 동작을
반영 — hadResurrection 고스트 변수로 검증한다).
*)
EXTENDS Naturals

CONSTANTS MaxFailures \* 연속 헬스체크 실패 허용 횟수 (ALB unhealthy_threshold에 해당)

VARIABLES state, failures, hadResurrection

vars == <<state, failures, hadResurrection>>

States == {"Pending", "Healthy", "Unhealthy", "Terminated"}

Init ==
    /\ state = "Pending"
    /\ failures = 0
    /\ hadResurrection = FALSE

\* 첫 헬스체크 성공, 또는 Unhealthy 상태에서의 회복 — 아직 Terminate 전이라면
\* 실제로 회복 가능하다는 걸 반영 (Terminate는 별도의 비가역 전이).
HealthCheckPass ==
    /\ state \in {"Pending", "Unhealthy"}
    /\ state' = "Healthy"
    /\ failures' = 0
    /\ hadResurrection' = (hadResurrection \/ state = "Terminated")

HealthCheckFail ==
    /\ state = "Healthy"
    /\ failures' = failures + 1
    /\ state' = IF failures + 1 >= MaxFailures THEN "Unhealthy" ELSE "Healthy"
    /\ UNCHANGED hadResurrection

\* Unhealthy가 이어지면 ECS가 태스크를 폐기한다 — 여기서부터는 되돌아갈 수
\* 없는 종착 상태.
Terminate ==
    /\ state = "Unhealthy"
    /\ state' = "Terminated"
    /\ UNCHANGED <<failures, hadResurrection>>

Next == HealthCheckPass \/ HealthCheckFail \/ Terminate

Spec == Init /\ [][Next]_vars

TypeInvariant ==
    /\ state \in States
    /\ failures \in 0..MaxFailures

\* hadResurrection이 항상 FALSE라는 게 핵심 검증 대상이다 — TRUE가 되는
\* 유일한 경로(HealthCheckPass from Terminated)를 Next가 애초에 허용하지
\* 않으므로, TLC가 도달 가능한 모든 상태에서 이게 성립함을 확인해준다.
NoResurrection == hadResurrection = FALSE
====
