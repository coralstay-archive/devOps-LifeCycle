---- MODULE spec ----
(*
학습 목적: password는 variables.tf에서 sensitive = true지만, 이 모듈은
rds-postgres/redshift와 달리 AWS 관리형 비밀번호 기능이 없다 —
그래서 이 값이 새어나갈 수 있는 유일한 경로는 이 모듈의 출력이다.
outputs.tf에는 broker_id와 endpoints뿐이라는 걸 후행조건으로 못박아,
"출력에 비밀번호 필드가 없다"는 게 우연이 아니라 강제된 성질임을
드러낸다 — secrets-manager 모듈의 같은 종류의 동작과 짝을 이룬다.

참고 문서:
- Amazon MQ API: CreateBroker
  — modules/amazon-mq/README.md의 공식문서 절 참고
*)
EXTENDS Naturals, Sequences, TLC

CONSTANTS
    Name,          \* STRING
    EngineType,    \* "RabbitMQ" 또는 "ActiveMQ"
    Username,      \* STRING
    Password       \* STRING (sensitive)

Input == [
    name         |-> Name,
    engine_type  |-> EngineType,
    username     |-> Username,
    password     |-> Password
]

Precondition(input) ==
    /\ input.name \in STRING /\ input.name # ""
    /\ input.engine_type \in {"RabbitMQ", "ActiveMQ"}
    /\ input.username \in STRING /\ input.username # ""
    /\ input.password \in STRING /\ Len(input.password) >= 12  \* Amazon MQ의 최소 비밀번호 길이 요구사항

\* 1. CreateBroker(name, engine_type, username, password,
\*    deployment_mode=SINGLE_INSTANCE — 첫 서브넷만 사용)
Provision(input) ==
    [
        broker_id  |-> "broker-" \o input.name,
        endpoints  |-> "amqps://" \o input.name \o ".mq.region.amazonaws.com:5671"
        \* 의도적으로 password/username 필드가 없다 — main.tf의 outputs.tf에도
        \* 그 값을 얻을 방법이 없다.
    ]

\* 이게 이 스펙의 핵심: 출력 레코드의 어떤 필드도 입력받은 비밀번호
\* 값과 같을 수 없다 — 리팩터링 중 실수로 비밀번호가 어느 출력 필드에
\* 흘러들어가는 걸 막는 마지막 방어선.
Postcondition(input, output) ==
    /\ "password" \notin DOMAIN output
    /\ \A f \in DOMAIN output : output[f] # input.password
    /\ output.broker_id \in STRING

VARIABLES dummy
vars == <<dummy>>
Init == dummy = TRUE
Next == UNCHANGED dummy
Spec == Init /\ [][Next]_vars

BehaviorHolds == Precondition(Input) => Postcondition(Input, Provision(Input))

====
