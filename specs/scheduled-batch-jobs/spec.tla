---- MODULE spec ----
(*
학습 목적: scheduled-batch-jobs는 EventBridge 스케줄 규칙이 주기적으로
ECS/Batch 작업을 트리거한다. 만약 이전 실행이 아직 끝나지 않았는데 다음
스케줄이 또 트리거되면(작업이 예상보다 오래 걸리는 경우), 동시에 두 인스턴스가
같은 배치 작업을 수행하며 데이터를 중복 처리할 수 있다 — 이를 막는
"동시 실행 방지(concurrency guard)" 동작을 여기서 명세한다.

핵심 안전 속성: 동시에 실행 중인 작업 인스턴스 수(runningCount)는 절대
1을 넘지 않는다 — EventBridge Scheduler의 flexible time window나
ECS 작업 정의의 실행 잠금(lock)이 실제로 보장해야 하는 바.
*)
EXTENDS Naturals

VARIABLES runningCount, skippedOverlap

vars == <<runningCount, skippedOverlap>>

Init ==
    /\ runningCount = 0
    /\ skippedOverlap = FALSE

\* 스케줄이 트리거됐을 때 이전 작업이 이미 끝난 상태라면 새 작업을 시작한다.
TriggerWhenIdle ==
    /\ runningCount = 0
    /\ runningCount' = 1
    /\ UNCHANGED skippedOverlap

\* 스케줄이 트리거됐는데 이전 작업이 아직 실행 중이면, 동시 실행 방지 로직이
\* 새 트리거를 건너뛴다(스킵) — 두 번째 인스턴스를 시작시키지 않는다.
TriggerWhileRunningIsSkipped ==
    /\ runningCount = 1
    /\ skippedOverlap' = TRUE
    /\ UNCHANGED runningCount

\* 실행 중이던 작업이 완료된다.
JobCompletes ==
    /\ runningCount = 1
    /\ runningCount' = 0
    /\ UNCHANGED skippedOverlap

Next == TriggerWhenIdle \/ TriggerWhileRunningIsSkipped \/ JobCompletes

Spec == Init /\ [][Next]_vars

TypeInvariant ==
    /\ runningCount \in 0..1
    /\ skippedOverlap \in BOOLEAN

\* 이게 이 스펙의 핵심: 동시 실행 방지 로직이 있는 한, 실행 중인 작업 인스턴스
\* 수는 언제나 최대 1개다 — 이 값이 2 이상이 되는 경로는 Next에 아예 없다.
NoOverlappingRuns == runningCount <= 1

====
