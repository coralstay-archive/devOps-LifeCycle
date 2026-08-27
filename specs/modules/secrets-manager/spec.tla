---- MODULE spec ----
(*
학습 목적: 이 모듈의 진짜 동작은 리소스
생성 순서가 아니라 보안 속성이다 — secret_string은 variables.tf에서
sensitive = true로 표시되는데, 그 값 자체가 절대 outputs.tf로 새어나가면
안 된다(출력은 오직 secret_arn/secret_id뿐, 실제 비밀 값은 출력에 없다).
이 "출력에 입력 비밀값이 나타나지 않는다"는 성질을 후행조건으로
명시적으로 검증 가능하게 만든다.

참고 문서:
- AWS Secrets Manager API: CreateSecret, PutSecretValue
  — modules/secrets-manager/README.md의 공식문서 절 참고
*)
EXTENDS Naturals, Sequences, TLC

Null == "null"

CONSTANTS
    Name,          \* STRING
    SecretString   \* STRING 또는 Null

Input == [
    name           |-> Name,
    secret_string  |-> SecretString
]

Precondition(input) ==
    /\ input.name \in STRING /\ input.name # ""
    /\ input.secret_string \in STRING

\* 1. CreateSecret(name) -> secret_arn/secret_id 확보 (값 없이 컨테이너만 생성)
\* 2. secret_string # null이면: PutSecretValue(secret_id, secret_string)로
\*    초기값 채움 — 하지만 이 값 자체는 이 모듈의 출력 어디에도 나타나지 않는다.
Provision(input) ==
    [
        secret_arn  |-> "arn:aws:secretsmanager:region:000000000000:secret:" \o input.name,
        secret_id   |-> input.name
        \* 의도적으로 secret_string을 여기 넣지 않는다 — outputs.tf에 없는
        \* 필드는 이 레코드에도 없어야, "출력에 비밀이 없다"는 동작을
        \* 타입 수준에서부터 강제할 수 있다.
    ]

\* 이게 이 스펙의 핵심: 출력 레코드의 어떤 필드에도 입력으로 받은
\* secret_string 값이 그대로 나타나서는 안 된다 — Provision의 반환
\* 레코드에 secret_string 필드 자체가 없다는 것 자체가 이미 이 속성을
\* 구조적으로 보장하지만, 명시적으로도 다시 확인한다(예: 다른 필드에
\* 실수로 값이 흘러들어가는 리팩터링 버그를 막기 위해).
Postcondition(input, output) ==
    /\ output.secret_arn \in STRING
    /\ output.secret_id = input.name
    /\ \A f \in DOMAIN output : output[f] # input.secret_string \/ input.secret_string = Null

VARIABLES dummy
vars == <<dummy>>
Init == dummy = TRUE
Next == UNCHANGED dummy
Spec == Init /\ [][Next]_vars

BehaviorHolds == Precondition(Input) => Postcondition(Input, Provision(Input))

====
