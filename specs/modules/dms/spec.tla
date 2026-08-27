---- MODULE spec ----
(*
학습 목적: 이 동작을 작성하다가 실제
main.tf의 진짜 갭을 하나 발견했다 — target_engine_name 기본값이
"kafka"이고 target_kafka_broker 기본값이 null인데, 그 조합을 막는
precondition이 없었다(source_port 검증만 있었음). kafka_settings.broker가
null인 채로 apply되면 DMS 엔드포인트 생성 시점에 훨씬 불친절한 에러가
난다 — 그래서 main.tf에 그 정확한 조합을 막는 precondition을 추가했다.
이 스펙의 Precondition은 그 수정된 제약을 그대로 반영한다.

참고 문서:
- AWS DMS API: CreateReplicationTask, CreateEndpoint
  — modules/dms/README.md의 공식문서 절 참고
*)
EXTENDS Naturals, Sequences, TLC

Null == "null"

CONSTANTS
    Name,               \* STRING
    SourcePort,         \* Nat, 1..65535
    TargetEngineName,   \* STRING
    TargetKafkaBroker   \* STRING 또는 Null

Input == [
    name                |-> Name,
    source_port         |-> SourcePort,
    target_engine_name  |-> TargetEngineName,
    target_kafka_broker |-> TargetKafkaBroker
]

\* main.tf의 두 lifecycle.precondition과 동일 — 하나는 원래 있던 것
\* (source_port), 하나는 이 동작을 쓰다가 발견해서 새로 추가한 것
\* (target_engine_name="kafka"인데 broker가 없는 조합 금지).
Precondition(input) ==
    /\ input.name \in STRING /\ input.name # ""
    /\ input.source_port \in 1..65535
    /\ input.target_engine_name \in STRING
    /\ (input.target_engine_name = "kafka" => input.target_kafka_broker # Null)

\* 1. CreateReplicationInstance
\* 2. CreateEndpoint(source, engine=source_engine_name)
\* 3. CreateEndpoint(target, engine=target_engine_name, kafka_settings.broker=target_kafka_broker)
\* 4. CreateReplicationTask(migration_type="full-load-and-cdc") — Full Load
\*    먼저, 그 다음부터 CDC로 계속 스트리밍(specs/cdc-pipeline의 런타임
\*    순서 보장이 바로 이 단계 이후의 이야기다)
Provision(input) ==
    [
        replication_instance_arn  |-> "arn:aws:dms:region:000000000000:rep:" \o input.name,
        replication_task_arn      |-> "arn:aws:dms:region:000000000000:task:" \o input.name,
        migration_type            |-> "full-load-and-cdc",
        target_broker_configured  |-> input.target_kafka_broker # Null
    ]

\* 이게 이 스펙의 핵심: target_engine_name이 kafka라면 target_broker가
\* 반드시 설정되어 있어야 한다 — Precondition이 이미 이걸 걸러내므로
\* Provision을 통과한 결과는 항상 이 성질을 만족해야 한다.
Postcondition(input, output) ==
    /\ (input.target_engine_name = "kafka" => output.target_broker_configured)
    /\ output.migration_type = "full-load-and-cdc"

VARIABLES dummy
vars == <<dummy>>
Init == dummy = TRUE
Next == UNCHANGED dummy
Spec == Init /\ [][Next]_vars

BehaviorHolds == Precondition(Input) => Postcondition(Input, Provision(Input))

====
