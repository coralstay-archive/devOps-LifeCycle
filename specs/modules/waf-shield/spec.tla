---- MODULE spec ----
(*
학습 목적: scope는 WAFv2가 실제로 허용하는 두 값(REGIONAL/CLOUDFRONT)
중 하나여야 한다는 사전조건, 그리고 두 개의 선택적 리소스(Web ACL
연결, Shield Advanced 보호)가 각각 정확히 어떤 조건에서만 생기는지가
핵심 동작 — resource_arn이 없으면 scope와 무관하게 둘 다 안 생겨야
하고, CLOUDFRONT scope에서는 별도 연결 리소스 자체가 존재하면 안 된다
(CloudFront는 자기 자신의 web_acl_id 인자로 붙기 때문).

참고 문서:
- AWS WAFv2 API: CreateWebACL, AssociateWebACL
  — modules/waf-shield/README.md의 공식문서 절 참고
*)
EXTENDS Naturals, Sequences, TLC

Null == "null"

CONSTANTS
    Name,                    \* STRING
    Scope,                   \* "REGIONAL" 또는 "CLOUDFRONT"
    ResourceArn,             \* STRING 또는 Null
    EnableShieldAdvanced     \* BOOLEAN

Input == [
    name                    |-> Name,
    scope                   |-> Scope,
    resource_arn            |-> ResourceArn,
    enable_shield_advanced  |-> EnableShieldAdvanced
]

\* main.tf의 lifecycle.precondition과 동일 — WAFv2 API가 실제로 허용하는
\* 값은 이 둘뿐이다.
Precondition(input) ==
    /\ input.name \in STRING /\ input.name # ""
    /\ input.scope \in {"REGIONAL", "CLOUDFRONT"}
    /\ input.resource_arn \in STRING
    /\ input.enable_shield_advanced \in BOOLEAN

\* 1. CreateWebACL(name, scope, default_action=allow,
\*    rules=[AWSManagedRulesCommonRuleSet])
\* 2. scope="REGIONAL" 이고 resource_arn이 있으면: AssociateWebACL(resource_arn, web_acl_arn)
\* 3. enable_shield_advanced 이고 resource_arn이 있으면: CreateProtection(resource_arn)
Provision(input) ==
    [
        web_acl_arn        |-> "arn:aws:wafv2:region:000000000000:webacl/" \o input.name,
        associated         |-> input.scope = "REGIONAL" /\ input.resource_arn # Null,
        shield_protected   |-> input.enable_shield_advanced /\ input.resource_arn # Null
    ]

\* 이게 이 스펙의 핵심: CLOUDFRONT scope에서는 이 모듈이 만드는 연결
\* 리소스가 절대 있으면 안 되고(CloudFront가 자기 web_acl_id로 붙으므로
\* 이중으로 연결하면 안 됨), resource_arn이 없으면 두 선택적 리소스
\* 모두 없어야 한다.
Postcondition(input, output) ==
    /\ (input.scope = "CLOUDFRONT" => output.associated = FALSE)
    /\ (input.resource_arn = Null => output.associated = FALSE /\ output.shield_protected = FALSE)
    /\ output.web_acl_arn \in STRING

VARIABLES dummy
vars == <<dummy>>
Init == dummy = TRUE
Next == UNCHANGED dummy
Spec == Init /\ [][Next]_vars

BehaviorHolds == Precondition(Input) => Postcondition(Input, Provision(Input))

====
