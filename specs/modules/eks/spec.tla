---- MODULE spec ----
(*
학습 목적: EKS는 관리형 컨트롤 플레인이라
s3-bucket처럼 "이 API들을 이 순서로 호출한다"고 상세히 알고리즘화하기
어렵다(AWS가 컨트롤 플레인 내부를 관리한다) — 그래서 OPERATION을
"관리형 리소스를 이 설정으로 프로비저닝한다"는 더 추상화된 동사로
표현한다. 대신 이 모듈이 실제로 강제하는 논리적 제약(스케일링 범위의
일관성)은 정확히 후행조건으로 표현할 수 있다.

참고 문서:
- Amazon EKS API: CreateCluster, CreateNodegroup
  — modules/eks/README.md의 공식문서 절 참고
*)
EXTENDS Naturals, Sequences, TLC

CONSTANTS
    ClusterName,      \* STRING
    VpcId,            \* STRING
    NodeDesiredSize,  \* Nat
    NodeMinSize,      \* Nat
    NodeMaxSize       \* Nat

PrivateSubnetIds == <<"subnet-a", "subnet-b">>

Input == [
    cluster_name       |-> ClusterName,
    vpc_id             |-> VpcId,
    private_subnet_ids |-> PrivateSubnetIds,
    node_desired_size  |-> NodeDesiredSize,
    node_min_size      |-> NodeMinSize,
    node_max_size      |-> NodeMaxSize
]

\* main.tf의 lifecycle.precondition과 동일 — 자기모순적 스케일링 범위는
\* EKS API가 어차피 거부하므로 여기서 입력 도메인 자체를 제한한다.
Precondition(input) ==
    /\ input.cluster_name \in STRING /\ input.cluster_name # ""
    /\ Len(input.private_subnet_ids) >= 2
    /\ input.node_min_size <= input.node_desired_size
    /\ input.node_desired_size <= input.node_max_size

\* 관리형 리소스 프로비저닝(추상화): 컨트롤 플레인 내부 동작은 AWS가
\* 관리하므로 "이런 설정으로 만들어진 관리형 클러스터가 존재한다"는
\* 결과만 모델링한다.
Provision(input) ==
    [
        cluster_name       |-> input.cluster_name,
        cluster_endpoint   |-> "https://" \o input.cluster_name \o ".eks.amazonaws.com",
        node_role_arn      |-> "arn:aws:iam::000000000000:role/" \o input.cluster_name \o "-node",
        effective_desired  |-> input.node_desired_size
    ]

\* 이게 이 스펙의 핵심: 엔드포인트/역할은 항상 나와야 하고(클러스터 없이
\* 워커 노드를 join시키는 게 불가능하므로), 실제 반영된 desired 크기는
\* 입력받은 min/max 범위 안에 있어야 한다.
Postcondition(input, output) ==
    /\ output.cluster_endpoint \in STRING
    /\ output.node_role_arn \in STRING
    /\ input.node_min_size <= output.effective_desired
    /\ output.effective_desired <= input.node_max_size

VARIABLES dummy
vars == <<dummy>>
Init == dummy = TRUE
Next == UNCHANGED dummy
Spec == Init /\ [][Next]_vars

BehaviorHolds == Precondition(Input) => Postcondition(Input, Provision(Input))

====
