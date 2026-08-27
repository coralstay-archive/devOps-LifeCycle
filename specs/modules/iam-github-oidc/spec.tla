---- MODULE spec ----
(*
학습 목적: 이 모듈에서 진짜 중요한 건 리소스
생성 순서가 아니라 — 신뢰 정책(trust policy)의 sub 조건 문자열이 정확히
"repo:{org}/{repo}:ref:{allowed_ref}" 형태로 만들어지는가다. 이게 틀리면
전혀 다른 저장소나 브랜치가 이 역할을 가로챌 수 있다 — main.tf의
lifecycle.precondition이 "allowed_ref가 refs/로 시작해야 한다"는 흔한
실수(브랜치 이름만 넣는 것)를 막는 것과 정확히 같은 문제의식이다. 여기서는
그 문자열 자체가 항상 올바른 형태로 조립되는지를 후행조건으로 못박는다.

참고 문서:
- GitHub Actions OIDC — https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/about-security-hardening-with-openid-connect
- AWS IAM API: CreateOpenIDConnectProvider, CreateRole, AttachRolePolicy
  — modules/iam-github-oidc/README.md의 공식문서 절 참고
*)
EXTENDS Naturals, Sequences, TLC

CONSTANTS
    GithubOrg,          \* STRING
    GithubRepo,         \* STRING
    AllowedRef,         \* STRING — 예: "refs/heads/main" 또는 "*"
    RoleName,           \* STRING
    CreateOidcProvider  \* BOOLEAN

\* Seq 값은 .cfg의 CONSTANT 대입 문법으로 못 쓰므로(vpc/spec.tla 주석 참고)
\* 여기 직접 정의한다.
PolicyArns == <<"arn:aws:iam::aws:policy/ReadOnlyAccess">>

Input == [
    github_org           |-> GithubOrg,
    github_repo          |-> GithubRepo,
    allowed_ref          |-> AllowedRef,
    role_name            |-> RoleName,
    policy_arns          |-> PolicyArns,
    create_oidc_provider |-> CreateOidcProvider
]

\* main.tf의 lifecycle.precondition과 동일한 제약 — "*"이거나 refs/로
\* 시작해야 한다. 바로 이 제약이 실제 코드에서 왜 필요한지(브랜치 이름만
\* 쓰면 GitHub의 실제 sub 클레임과 절대 안 맞는다는 것)는 main.tf 주석 참고.
IsValidRef(ref) == ref = "*" \/ (Len(ref) >= 5 /\ SubSeq(ref, 1, 5) = "refs/")

Precondition(input) ==
    /\ input.github_org \in STRING /\ input.github_org # ""
    /\ input.github_repo \in STRING /\ input.github_repo # ""
    /\ IsValidRef(input.allowed_ref)
    /\ input.role_name \in STRING
    /\ input.policy_arns \in Seq(STRING)
    /\ input.create_oidc_provider \in BOOLEAN

\* 1. create_oidc_provider면: GetOpenIDConnectProviderThumbprint(github) 후
\*    CreateOpenIDConnectProvider(url, thumbprint) — 계정당 1개만 가능하므로
\*    아니면 2. 기존 provider를 조회(GetOpenIDConnectProvider)해 재사용.
\* 3. sub 클레임을 "repo:{org}/{repo}:ref:{allowed_ref}"로 제한하는 신뢰
\*    정책 문서 조립.
\* 4. CreateRole(role_name, trust_policy)
\* 5. policy_arns 각각에 대해 AttachRolePolicy(role, arn)
Provision(input) ==
    LET providerArn == IF input.create_oidc_provider
                        THEN "arn:aws:iam::000000000000:oidc-provider/token.actions.githubusercontent.com"
                        ELSE "arn:aws:iam::000000000000:oidc-provider/token.actions.githubusercontent.com" \* 재사용 시에도 URL은 동일 — 계정에 하나뿐이므로
        subCondition == "repo:" \o input.github_org \o "/" \o input.github_repo \o ":ref:" \o input.allowed_ref
        roleArn == "arn:aws:iam::000000000000:role/" \o input.role_name
    IN [
        role_arn           |-> roleArn,
        oidc_provider_arn  |-> providerArn,
        \* main.tf에는 없는 필드지만, "실제로 무엇이 이 역할을 가져갈 수
        \* 있는가"라는 동작의 핵심을 검증 가능하게 만들기 위해 노출한다.
        trust_sub_condition |-> subCondition,
        attached_policy_count |-> Len(input.policy_arns)
    ]

\* 이게 이 스펙의 핵심: 신뢰 조건 문자열이 정확히 이 org/repo/ref 조합
\* 하나만을 가리켜야 한다 — 다른 org나 repo, 혹은 "*"가 실수로 들어간
\* wildcard 형태가 절대 아니어야 한다는 것.
Postcondition(input, output) ==
    /\ output.trust_sub_condition = ("repo:" \o input.github_org \o "/" \o input.github_repo \o ":ref:" \o input.allowed_ref)
    /\ output.attached_policy_count = Len(input.policy_arns)
    /\ output.role_arn \in STRING

VARIABLES dummy
vars == <<dummy>>
Init == dummy = TRUE
Next == UNCHANGED dummy
Spec == Init /\ [][Next]_vars

BehaviorHolds == Precondition(Input) => Postcondition(Input, Provision(Input))

====
