---- MODULE spec ----
(*
학습 목적: rds-postgres와 똑같이
manage_master_password = true로 AWS가 비밀번호를 관리하지만, 이 모듈은
그 비밀이 담긴 Secrets Manager ARN을 outputs.tf에 아예 노출하지
않는다(endpoint, cluster_id뿐) — rds-postgres보다도 더 추상화된
"관리형 클러스터가 존재한다"만 모델링하는 게 여기서는 더 정직한
표현이다. 이건 실제로 이 모듈의 알려진 한계(README의 "아직 포함 안 된
것" 참고)이기도 하다.

참고 문서:
- Amazon Redshift API: CreateCluster
  — modules/redshift/README.md의 공식문서 절 참고
*)
EXTENDS Naturals, Sequences, TLC

CONSTANTS
    ClusterIdentifier,  \* STRING
    MasterUsername,     \* STRING
    DatabaseName        \* STRING

Input == [
    cluster_identifier  |-> ClusterIdentifier,
    master_username     |-> MasterUsername,
    database_name       |-> DatabaseName
]

Precondition(input) ==
    /\ input.cluster_identifier \in STRING /\ input.cluster_identifier # ""
    /\ input.master_username \in STRING /\ input.master_username # ""
    /\ input.database_name \in STRING /\ input.database_name # ""

\* 관리형 리소스 프로비저닝(추상화): 노드 내부 배치/암호화 키 관리는
\* AWS가 담당하므로, "이 설정으로 만들어진 클러스터가 존재하고 항상
\* 암호화되어 있다"는 결과만 모델링한다.
Provision(input) ==
    [
        endpoint     |-> input.cluster_identifier \o ".xxxxx.region.redshift.amazonaws.com:5439",
        cluster_id   |-> input.cluster_identifier,
        encrypted    |-> TRUE  \* main.tf에 이걸 끌 변수가 없다 — 항상 켜짐
        \* 의도적으로 password/secret 필드가 없다 — 이 모듈의 실제
        \* outputs.tf에도 그 값을 얻을 방법이 없다(README의 알려진 한계).
    ]

Postcondition(input, output) ==
    /\ output.encrypted = TRUE
    /\ output.cluster_id = input.cluster_identifier
    /\ "password" \notin DOMAIN output
    /\ "secret_arn" \notin DOMAIN output

VARIABLES dummy
vars == <<dummy>>
Init == dummy = TRUE
Next == UNCHANGED dummy
Spec == Init /\ [][Next]_vars

BehaviorHolds == Precondition(Input) => Postcondition(Input, Provision(Input))

====
