---- MODULE spec ----
(*
학습 목적: 이 모듈(범용 IAM 역할)의 진짜 동작은 "누가 이
역할을 맡을 수 있는가"(assume_role_services)와 "이 역할이 뭘 할 수
있는가"(managed_policy_arns + inline_policy_json)가 입력에서 정확히
그대로 출력(신뢰 정책, 연결된 정책 목록)에 반영되는지다.
*)
EXTENDS Naturals, Sequences, TLC

CONSTANTS
    Name,                 \* STRING
    HasInlinePolicy       \* BOOLEAN — inline_policy_json이 null이 아닌지

\* Seq 값은 .cfg의 CONSTANT 대입 문법으로 못 쓰므로(vpc/spec.tla 주석 참고)
\* 여기 직접 정의한다.
AssumeRoleServices == <<"ec2.amazonaws.com">>
ManagedPolicyArns == <<"arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess">>

Input == [
    name                  |-> Name,
    assume_role_services  |-> AssumeRoleServices,
    managed_policy_arns   |-> ManagedPolicyArns,
    has_inline_policy     |-> HasInlinePolicy
]

Precondition(input) ==
    /\ input.name \in STRING /\ input.name # ""
    /\ input.assume_role_services \in Seq(STRING)
    /\ Len(input.assume_role_services) > 0  \* 아무도 못 맡는 역할은 무의미
    /\ input.managed_policy_arns \in Seq(STRING)
    /\ input.has_inline_policy \in BOOLEAN

\* 1. AssumeRolePolicyDocument 조립 — Principal.Service = assume_role_services
\* 2. CreateRole(name, assume_role_policy)
\* 3. managed_policy_arns 각각에 대해 AttachRolePolicy
\* 4. has_inline_policy면 PutRolePolicy(inline)
Provision(input) ==
    LET roleArn == "arn:aws:iam::000000000000:role/" \o input.name
    IN [
        role_arn                |-> roleArn,
        role_name                |-> input.name,
        trusted_services         |-> input.assume_role_services,
        attached_managed_count   |-> Len(input.managed_policy_arns),
        has_inline_policy_output |-> input.has_inline_policy
    ]

\* 이게 이 스펙의 핵심: 신뢰할 서비스 목록은 입력 그대로여야 하고(더
\* 넓히거나 좁히면 안 됨), 연결된 관리형 정책 개수도 입력과 정확히
\* 일치해야 한다 — "선언한 것과 실제로 생기는 것이 같다"는 가장 기본적인
\* Terraform 모듈의 약속.
Postcondition(input, output) ==
    /\ output.trusted_services = input.assume_role_services
    /\ output.attached_managed_count = Len(input.managed_policy_arns)
    /\ output.has_inline_policy_output = input.has_inline_policy
    /\ output.role_arn \in STRING

VARIABLES dummy
vars == <<dummy>>
Init == dummy = TRUE
Next == UNCHANGED dummy
Spec == Init /\ [][Next]_vars

BehaviorHolds == Precondition(Input) => Postcondition(Input, Provision(Input))

====
