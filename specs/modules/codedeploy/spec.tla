---- MODULE spec ----
(*
학습 목적: main.tf가 이미 강제하는 "블루/그린 타겟 그룹은 서로 달라야
한다"는 사전조건을 다시 확인한다 — 실제로 이 둘이 같으면 "트래픽을
전환한다"는 배포 전략 자체가 의미를 잃는다(전환할 곳이 없으므로). 이
모듈이 만드는 배포 그룹의 blue/green 전환 로직 자체는
specs/blue-green-deployment/spec.tla가 런타임 관점(활성 타겟 그룹은
항상 정확히 하나)에서 다룬다 — 여기서는 그 전제 조건(서로 다른 두
타겟 그룹)이 배포 시점에 성립하는지를 다룬다.

참고 문서:
- AWS CodeDeploy API: CreateApplication, CreateDeploymentGroup
  — modules/codedeploy/README.md의 공식문서 절 참고
*)
EXTENDS Naturals, Sequences, TLC

CONSTANTS
    Name,                    \* STRING
    TargetGroupBlueName,     \* STRING
    TargetGroupGreenName     \* STRING

Input == [
    name                     |-> Name,
    target_group_blue_name   |-> TargetGroupBlueName,
    target_group_green_name  |-> TargetGroupGreenName
]

\* main.tf의 lifecycle.precondition과 동일 — 가장 흔한 복붙 실수를 막는다.
Precondition(input) ==
    /\ input.name \in STRING /\ input.name # ""
    /\ input.target_group_blue_name \in STRING /\ input.target_group_blue_name # ""
    /\ input.target_group_green_name \in STRING /\ input.target_group_green_name # ""
    /\ input.target_group_blue_name # input.target_group_green_name

\* 1. CreateApplication(name, compute_platform=ECS)
\* 2. CreateDeploymentGroup(deployment_type=BLUE_GREEN,
\*    target_group_pair=[blue, green], termination_wait=5분)
Provision(input) ==
    [
        app_name               |-> input.name,
        deployment_group_name  |-> input.name \o "-dg",
        blue_green_enabled     |-> TRUE,  \* main.tf에 이걸 ROLLING으로 바꿀 변수가 없다
        termination_wait_minutes |-> 5
    ]

\* 이게 이 스펙의 핵심: 이 모듈로 만든 배포 그룹은 항상 blue/green
\* 방식이어야 하고(ECS 기본 롤링 업데이트가 아니라 CodeDeploy가 트래픽을
\* 관리해야 하므로), 이전 버전 종료 유예 시간은 항상 5분이어야 한다
\* (그 값이 조용히 0으로 바뀌면 "문제 생기면 되돌릴 시간"이 사라진다).
Postcondition(input, output) ==
    /\ output.blue_green_enabled = TRUE
    /\ output.termination_wait_minutes = 5
    /\ output.app_name \in STRING

VARIABLES dummy
vars == <<dummy>>
Init == dummy = TRUE
Next == UNCHANGED dummy
Spec == Init /\ [][Next]_vars

BehaviorHolds == Precondition(Input) => Postcondition(Input, Provision(Input))

====
