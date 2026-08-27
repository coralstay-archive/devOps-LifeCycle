---- MODULE spec ----
(*
학습 목적: blue-green-deployment는 alb 모듈의 리스너 규칙(또는 CodeDeploy의
blue/green 훅)으로 트래픽을 blue 환경에서 green 환경으로 전환한다. 핵심은
"전환"이 이름 그대로 원자적(atomic)이어야 한다는 것 — 어느 한 순간에
트래픽이 blue와 green에 동시에 갈라져 나가는 상태(split traffic)가 있으면
안 된다(그건 canary고, blue-green이 아니다). 그 차이를 여기서 명세한다.

핵심 안전 속성: ALB의 활성 타겟 그룹(activeTargetGroup)은 언제나 정확히
하나다 — blue-green 전환 도중에도 "둘 다 활성"이거나 "둘 다 비활성"인
순간이 없다.
*)
EXTENDS Naturals

VARIABLES activeTargetGroup

vars == <<activeTargetGroup>>

Init == activeTargetGroup = "blue"

\* ALB 리스너의 기본 액션을 blue 타겟 그룹에서 green 타겟 그룹으로
\* 원자적으로(하나의 API 호출로) 바꾼다 — 중간 상태가 없다.
SwitchToGreen ==
    /\ activeTargetGroup = "blue"
    /\ activeTargetGroup' = "green"

\* 문제가 생기면 즉시 blue로 롤백한다 — 이것도 원자적 전환.
RollbackToBlue ==
    /\ activeTargetGroup = "green"
    /\ activeTargetGroup' = "blue"

Next == SwitchToGreen \/ RollbackToBlue

Spec == Init /\ [][Next]_vars

\* 이게 이 스펙의 핵심: activeTargetGroup은 하나의 변수이므로 정의상 항상
\* 정확히 하나의 값만 가진다 — "둘 다 활성"이라는 상태 자체가 이 모델에서는
\* 표현 불가능하다는 것이, 곧 원자적 전환이 강제된다는 뜻이다.
TypeInvariant == activeTargetGroup \in {"blue", "green"}

====
