---- MODULE spec ----
(*
학습 목적: 실시간 추론 엔드포인트가 나오려면
반드시 model_data_url(학습된 아티팩트)과 container_image(서빙 코드)가
둘 다 있어야 한다 — 이 관계형 ML 배포 파이프라인 자체는
specs/ml-realtime-inference/spec.tla가 런타임 관점(blue/green 무중단
갱신)에서 다루고, 여기서는 배포 시점의 입력 동작만 다룬다.

참고 문서:
- Amazon SageMaker API: CreateModel, CreateEndpointConfig, CreateEndpoint
  — modules/sagemaker/README.md의 공식문서 절 참고
*)
EXTENDS Naturals, Sequences, TLC

CONSTANTS
    Name,                    \* STRING
    ContainerImage,          \* STRING
    ModelDataUrl,            \* STRING, s3:// 경로
    InitialInstanceCount     \* Nat

Input == [
    name                     |-> Name,
    container_image          |-> ContainerImage,
    model_data_url           |-> ModelDataUrl,
    initial_instance_count   |-> InitialInstanceCount
]

Precondition(input) ==
    /\ input.name \in STRING /\ input.name # ""
    /\ input.container_image \in STRING /\ input.container_image # ""
    /\ input.model_data_url \in STRING
    /\ Len(input.model_data_url) >= 5 /\ SubSeq(input.model_data_url, 1, 5) = "s3://"
    /\ input.initial_instance_count >= 1

\* 1. CreateModel(container_image, model_data_url) -> model
\* 2. CreateEndpointConfig(model, instance_type, initial_instance_count)
\* 3. CreateEndpoint(endpoint_config) -> endpoint_name
\* 4. CreateRole(name + "-role") — SageMaker가 S3에서 모델을 읽어올 실행 역할
Provision(input) ==
    [
        endpoint_name  |-> input.name \o "-endpoint",
        role_arn       |-> "arn:aws:iam::000000000000:role/" \o input.name \o "-role",
        instance_count |-> input.initial_instance_count
    ]

\* 이게 이 스펙의 핵심: 반영된 인스턴스 수는 항상 1 이상이어야 한다 —
\* 0개 인스턴스인 "엔드포인트"는 모든 추론 요청이 실패하는 상태다.
Postcondition(input, output) ==
    /\ output.instance_count >= 1
    /\ output.instance_count = input.initial_instance_count
    /\ output.role_arn \in STRING

VARIABLES dummy
vars == <<dummy>>
Init == dummy = TRUE
Next == UNCHANGED dummy
Spec == Init /\ [][Next]_vars

BehaviorHolds == Precondition(Input) => Postcondition(Input, Provision(Input))

====
