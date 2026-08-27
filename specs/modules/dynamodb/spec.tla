---- MODULE spec ----
(*
학습 목적: hash_key_type은 DynamoDB API가
실제로 허용하는 세 값(S/N/B) 중 하나여야 한다는 것과, 테이블의 키 스키마가
정확히 그 타입으로 반영되는지가 핵심 동작.

참고 문서:
- Amazon DynamoDB API: CreateTable
  — modules/dynamodb/README.md의 공식문서 절 참고
*)
EXTENDS Naturals, Sequences, TLC

CONSTANTS
    TableName,   \* STRING
    HashKey,     \* STRING
    HashKeyType  \* "S", "N", 또는 "B"

Input == [
    table_name     |-> TableName,
    hash_key       |-> HashKey,
    hash_key_type  |-> HashKeyType
]

\* DynamoDB API가 실제로 허용하는 속성 타입은 이 세 가지뿐이다(String,
\* Number, Binary) — 다른 값을 넣으면 CreateTable 자체가 실패한다.
Precondition(input) ==
    /\ input.table_name \in STRING /\ input.table_name # ""
    /\ input.hash_key \in STRING /\ input.hash_key # ""
    /\ input.hash_key_type \in {"S", "N", "B"}

\* 1. CreateTable(table_name, key_schema=[{hash_key, HASH}],
\*    attribute_definitions=[{hash_key, hash_key_type}], billing_mode=PAY_PER_REQUEST)
Provision(input) ==
    [
        table_name     |-> input.table_name,
        table_arn      |-> "arn:aws:dynamodb:region:000000000000:table/" \o input.table_name,
        key_schema     |-> [attribute_name |-> input.hash_key, key_type |-> "HASH"],
        attribute_type |-> input.hash_key_type
    ]

\* 이게 이 스펙의 핵심: 테이블의 파티션 키 이름과 타입은 반드시 입력과
\* 정확히 일치해야 한다 — 다르면 애플리케이션이 쓰려는 키로 아이템을
\* 절대 조회할 수 없는 조용한 실패로 이어진다.
Postcondition(input, output) ==
    /\ output.key_schema.attribute_name = input.hash_key
    /\ output.key_schema.key_type = "HASH"
    /\ output.attribute_type = input.hash_key_type

VARIABLES dummy
vars == <<dummy>>
Init == dummy = TRUE
Next == UNCHANGED dummy
Spec == Init /\ [][Next]_vars

BehaviorHolds == Precondition(Input) => Postcondition(Input, Provision(Input))

====
