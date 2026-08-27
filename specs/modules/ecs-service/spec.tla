---- MODULE spec ----
(*
학습 목적: target_group_arn이 null이면
로드밸런서 없이 서비스만 돌고, 아니면 서비스가 그 타겟 그룹에 등록된다 —
이 분기가 정확히 반영되는지가 핵심 동작.
*)
EXTENDS Naturals, Sequences, TLC

Null == "null"

CONSTANTS
    Name,             \* STRING
    ContainerImage,   \* STRING
    DesiredCount,     \* Nat
    TargetGroupArn    \* STRING 또는 Null

Input == [
    name              |-> Name,
    container_image   |-> ContainerImage,
    desired_count     |-> DesiredCount,
    target_group_arn  |-> TargetGroupArn
]

Precondition(input) ==
    /\ input.name \in STRING /\ input.name # ""
    /\ input.container_image \in STRING /\ input.container_image # ""
    /\ input.desired_count \in Nat /\ input.desired_count >= 1
    /\ input.target_group_arn \in STRING

\* 관리형 리소스 프로비저닝(추상화): ECS 스케줄러가 태스크 배치를 내부적으로
\* 관리하므로, "이 설정으로 서비스가 등록되어 있다"는 결과만 모델링한다.
Provision(input) ==
    [
        cluster_name         |-> input.name \o "-cluster",
        service_name         |-> input.name \o "-svc",
        security_group_id    |-> "sg-" \o input.name,
        registered_to_target_group |-> input.target_group_arn # Null
    ]

\* 이게 이 스펙의 핵심: target_group_arn을 줬다면 서비스는 반드시 그
\* 타겟 그룹에 등록된 상태여야 하고(안 그러면 ALB가 이 서비스로 트래픽을
\* 절대 못 보냄), 안 줬다면 등록되지 않은 상태(로드밸런서 없이 단독 실행)
\* 여야 한다.
Postcondition(input, output) ==
    /\ output.registered_to_target_group = (input.target_group_arn # Null)
    /\ output.service_name \in STRING

VARIABLES dummy
vars == <<dummy>>
Init == dummy = TRUE
Next == UNCHANGED dummy
Spec == Init /\ [][Next]_vars

BehaviorHolds == Precondition(Input) => Postcondition(Input, Provision(Input))

====
