---- MODULE spec ----
(*
학습 목적: 이 모듈은 이미 main.tf의
lifecycle.precondition으로 "deletion_window_in_days는 7~30일 사이"라는
KMS API 자체의 제약을 강제하고 있다(decision-2가 다루는 모듈 스코프
precondition/postcondition) — 여기서는 그 동일한 제약을
사전조건(precondition)으로 다시 표현해, "입력 도메인 제약"과 "알고리즘이
그 도메인 안에서 실제로 무엇을 보장하는가(후행조건)"를 분리해서 보여주는
용도로 쓴다.

참고 문서:
- AWS KMS API: CreateKey, CreateAlias — modules/kms/README.md의 공식문서 절 참고
*)
EXTENDS Naturals, Sequences, TLC

CONSTANTS
    Name,                    \* STRING
    DeletionWindowInDays     \* Nat, 7..30

Input == [
    name                      |-> Name,
    deletion_window_in_days   |-> DeletionWindowInDays
]

\* main.tf의 lifecycle.precondition과 동일한 제약 — KMS API가 실제로
\* 강제하는 범위이지 이 모듈이 임의로 정한 스타일이 아니다.
Precondition(input) ==
    /\ input.name \in STRING /\ input.name # ""
    /\ input.deletion_window_in_days \in 7..30

\* 1. CreateKey(deletion_window_in_days, enable_key_rotation=TRUE)
\* 2. CreateAlias("alias/" + name, target_key_id)
Provision(input) ==
    [
        key_id       |-> "key-" \o input.name,
        key_arn      |-> "arn:aws:kms:region:000000000000:key/key-" \o input.name,
        alias_name   |-> "alias/" \o input.name,
        key_rotation_enabled |-> TRUE  \* main.tf에 이걸 끌 수 있는 변수가 없다 — 항상 켜짐
    ]

\* 이게 이 스펙의 핵심: alias_name은 항상 "alias/" 접두어 + name 형태여야
\* 하고(오타 하나로 다른 키를 가리키는 사고 방지), 키 로테이션은 옵션이
\* 아니라 항상 켜져 있어야 한다.
Postcondition(input, output) ==
    /\ output.alias_name = ("alias/" \o input.name)
    /\ output.key_rotation_enabled = TRUE
    /\ output.key_arn \in STRING

VARIABLES dummy
vars == <<dummy>>
Init == dummy = TRUE
Next == UNCHANGED dummy
Spec == Init /\ [][Next]_vars

BehaviorHolds == Precondition(Input) => Postcondition(Input, Provision(Input))

====
