---- MODULE spec ----
(*
학습 목적: 이 모듈엔 master_password라는
변수가 아예 없다 — manage_master_user_password = true로 AWS가 비밀번호를
직접 생성해 Secrets Manager에 저장하게 위임한다. 그래서 이 모듈의 진짜
동작은 "비밀번호 자체는 절대 이 모듈의 출력에도, state에도 평문으로
나타나지 않고, 대신 그 비밀번호를 담은 Secrets Manager ARN만 나온다"는
것 — secrets-manager 모듈의 "출력에 비밀이 없다" 동작과 같은 종류의
속성이다.

참고 문서:
- Amazon RDS API: CreateDBInstance (ManageMasterUserPassword)
  — modules/rds-postgres/README.md의 공식문서 절 참고
*)
EXTENDS Naturals, Sequences, TLC

CONSTANTS
    Identifier,       \* STRING
    MasterUsername,   \* STRING
    MultiAz           \* BOOLEAN

Input == [
    identifier        |-> Identifier,
    master_username   |-> MasterUsername,
    multi_az          |-> MultiAz
]

Precondition(input) ==
    /\ input.identifier \in STRING /\ input.identifier # ""
    /\ input.master_username \in STRING /\ input.master_username # ""
    /\ input.multi_az \in BOOLEAN

\* 관리형 리소스 프로비저닝(추상화): 엔진 내부의 복제/페일오버 동작은
\* AWS가 관리하므로, "이 설정으로 만들어진 인스턴스가 존재하고, 비밀번호는
\* AWS가 관리한다"는 결과만 모델링한다.
Provision(input) ==
    [
        endpoint                |-> input.identifier \o ".xxxxx.us-east-1.rds.amazonaws.com:5432",
        db_instance_id          |-> input.identifier,
        master_user_secret_arn  |-> "arn:aws:secretsmanager:region:000000000000:secret:rds!db-" \o input.identifier,
        multi_az_enabled        |-> input.multi_az
        \* 의도적으로 "password" 필드가 없다 — main.tf에 master_password
        \* 변수 자체가 없으므로, 이 레코드 타입 자체가 "평문 비밀번호를
        \* 반환할 방법이 없다"를 구조적으로 보장한다.
    ]

\* 이게 이 스펙의 핵심: master_user_secret_arn은 반드시 나와야 하고
\* (비밀번호를 어디서도 못 찾으면 아무도 DB에 접속할 수 없다), 출력
\* 레코드의 어떤 필드도 "password"라는 이름을 가질 수 없다 — 애초에
\* 그런 필드가 스키마에 없다는 게 곧 "평문 비밀번호 유출 경로가 없다"는
\* 뜻이다.
Postcondition(input, output) ==
    /\ output.master_user_secret_arn \in STRING /\ output.master_user_secret_arn # ""
    /\ "password" \notin DOMAIN output
    /\ output.multi_az_enabled = input.multi_az

VARIABLES dummy
vars == <<dummy>>
Init == dummy = TRUE
Next == UNCHANGED dummy
Spec == Init /\ [][Next]_vars

BehaviorHolds == Precondition(Input) => Postcondition(Input, Provision(Input))

====
