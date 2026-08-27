---- MODULE spec ----
(*
학습 목적: ml-training-pipeline의 sagemaker 모듈은 학습 작업(Training Job)을
정의할 뿐이다. SageMaker 학습 작업의 실제 생명주기 — InProgress -> Completed
또는 Failed, 그리고 한 번 Completed/Failed로 확정되면 절대 다른 상태로
되돌아가지 않는다는 불변성(finality) — 은 Terraform이 아니라 SageMaker
런타임이 관리한다. 그 동작을 여기서 명세한다.

핵심 안전 속성: 학습 작업이 한 번 Completed로 확정되면, 모델 아티팩트가
S3에 이미 쓰였다는 뜻이므로 이후 그 작업이 다시 InProgress나 Failed로
바뀌는 일은 없다 — 최종 상태의 불변성.
*)
EXTENDS Naturals

VARIABLES state

vars == <<state>>

States == {"InProgress", "Completed", "Failed"}

Init == state = "InProgress"

\* 학습 데이터로 모델을 끝까지 학습시켜 아티팩트를 S3에 저장 완료.
Complete ==
    /\ state = "InProgress"
    /\ state' = "Completed"

\* 학습 중 오류(예: OOM, 잘못된 하이퍼파라미터)로 작업이 실패.
Fail ==
    /\ state = "InProgress"
    /\ state' = "Failed"

Next == Complete \/ Fail

Spec == Init /\ [][Next]_vars

TypeInvariant == state \in States

\* 이게 이 스펙의 핵심: Completed/Failed는 최종 상태 — 이 상태에서 나가는
\* 전이가 Next에 없으므로, 한 번 확정되면 영원히 그 상태로 남는다는 것을
\* 별도 증명 없이 Next의 구조 자체가 보장한다.
\*
\* 주의: `(state = "Completed") => [](state = "Completed")`처럼 바깥쪽 []
\* 없이 쓰면, Init에서 state가 항상 "InProgress"로 시작하는 한 이 조건은
\* t=0 시점에서 이미 거짓("Completed" 아님)이라 전체 behavior에서 공허하게
\* 항상 참이 되어버린다(observability-only-baseline에서 겪은 것과 같은
\* 종류의 버그) — Completed에서 다시 InProgress로 돌아가는 명백한 버그를
\* Next에 일부러 넣어도 TLC가 "No error"라고 말하는 걸로 직접 확인했다.
\* 올바른 관용구는 "안정성(stability)"을 behavior의 매 시점마다 검사하도록
\* 바깥에 []를 한 번 더 씌우는 것 — [](P => []P): "언제든 P가 참이면, 그
\* 순간부터는 영원히 P"라는 뜻이 되어야 실제로 매 시점에서 검증된다.
FinalStatesAreStable ==
    /\ [](state = "Completed" => [](state = "Completed"))
    /\ [](state = "Failed" => [](state = "Failed"))

====
