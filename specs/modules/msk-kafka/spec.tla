---- MODULE spec ----
(*
학습 목적: MSK API 자체가 브로커 수를 AZ
개수의 배수로 강제한다(브로커를 AZ마다 고르게 분산 배치해야 하므로) —
main.tf의 lifecycle.precondition과 동일한 제약을 사전조건으로
다시 표현한다.

참고 문서:
- Amazon MSK API: CreateCluster — modules/msk-kafka/README.md의 공식문서 절 참고
*)
EXTENDS Naturals, Sequences, TLC

PrivateSubnetIds == <<"subnet-a", "subnet-b">>

CONSTANTS
    ClusterName,          \* STRING
    NumberOfBrokerNodes   \* Nat, subnet 개수의 배수

Input == [
    cluster_name             |-> ClusterName,
    private_subnet_ids       |-> PrivateSubnetIds,
    number_of_broker_nodes   |-> NumberOfBrokerNodes
]

\* main.tf의 lifecycle.precondition과 동일 — MSK API 자체의 요구사항.
Precondition(input) ==
    /\ input.cluster_name \in STRING /\ input.cluster_name # ""
    /\ Len(input.private_subnet_ids) >= 2
    /\ input.number_of_broker_nodes % Len(input.private_subnet_ids) = 0
    /\ input.number_of_broker_nodes > 0

\* 관리형 리소스 프로비저닝(추상화): 브로커/파티션 배치 내부 로직은 AWS가
\* 관리하므로, "AZ마다 균등하게 배치된 브로커 수"만 계산해 모델링한다.
Provision(input) ==
    [
        bootstrap_brokers_tls     |-> "b-1." \o input.cluster_name \o ".kafka.us-east-1.amazonaws.com:9094",
        brokers_per_az            |-> input.number_of_broker_nodes \div Len(input.private_subnet_ids)
    ]

\* 이게 이 스펙의 핵심: AZ당 브로커 수가 정확히 나누어떨어져야 한다 —
\* 나머지가 남으면 그건 이 모델이 잘못 계산한 것이거나,애초에
\* Precondition을 통과하면 안 됐을 입력이라는 뜻이다.
Postcondition(input, output) ==
    /\ output.brokers_per_az * Len(input.private_subnet_ids) = input.number_of_broker_nodes
    /\ output.bootstrap_brokers_tls \in STRING

VARIABLES dummy
vars == <<dummy>>
Init == dummy = TRUE
Next == UNCHANGED dummy
Spec == Init /\ [][Next]_vars

BehaviorHolds == Precondition(Input) => Postcondition(Input, Provision(Input))

====
