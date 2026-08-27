---- MODULE spec ----
(*
학습 목적: cdc-pipeline은 dms 모듈로 "복제 태스크를 만들라"고 선언하지만,
DMS의 실제 동작은 두 단계다 — 먼저 원본 테이블 전체를 한 번 복사하는
Full Load, 그 다음부터 변경분만 흘려보내는 CDC(Change Data Capture). 이
순서를 건너뛰면(Full Load 끝나기 전에 CDC 이벤트를 먼저 적용하면) 타겟
데이터가 깨진다 — 그 순서 제약을 여기서 명세한다.

핵심 안전 속성: CDC 이벤트는 Full Load가 완료된 뒤에만 타겟에 적용될 수
있다 — DMS가 내부적으로 Full Load 동안 발생한 변경분을 버퍼링했다가
Full Load 완료 후 순서대로 재생하는 것과 동일한 보장.
*)
EXTENDS Naturals

VARIABLES phase, appliedOutOfOrder

vars == <<phase, appliedOutOfOrder>>

Phases == {"FullLoad", "CDC"}

Init ==
    /\ phase = "FullLoad"
    /\ appliedOutOfOrder = FALSE

\* Full Load 완료 — 이제부터 버퍼링된 변경분과 새 변경분을 순서대로 CDC로
\* 적용하기 시작한다.
FinishFullLoad ==
    /\ phase = "FullLoad"
    /\ phase' = "CDC"
    /\ UNCHANGED appliedOutOfOrder

\* CDC 단계에서만 변경 이벤트를 타겟에 실제로 적용한다.
ApplyChange ==
    /\ phase = "CDC"
    /\ UNCHANGED vars

\* 의도적으로 Next에서 뺀 "버그" 액션 — Full Load가 끝나기도 전에 CDC 이벤트를
\* 타겟에 적용해버리는 경로. 실수로 열리면 아래 불변식이 잡아낸다.
\* ApplyChangeDuringFullLoad ==
\*     /\ phase = "FullLoad"
\*     /\ appliedOutOfOrder' = TRUE
\*     /\ UNCHANGED phase

Next == FinishFullLoad \/ ApplyChange

Spec == Init /\ [][Next]_vars

TypeInvariant == phase \in Phases

NoOutOfOrderApply == appliedOutOfOrder = FALSE

====
