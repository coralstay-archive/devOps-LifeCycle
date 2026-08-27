---- MODULE spec ----
(*
학습 목적: main.tf가 이미 강제하는
"certificate_arn을 줬으면 aliases가 최소 1개"라는 제약(커스텀 인증서인데
그걸 서빙할 커스텀 도메인이 없는 건 모순)을 사전조건으로 재확인하고,
그 조합에 따라 cloudfront_default_certificate 플래그가 정확히 반대로
켜지는지 후행조건으로 검증한다.

참고 문서:
- Amazon CloudFront API: CreateDistribution
  — modules/cloudfront/README.md의 공식문서 절 참고
*)
EXTENDS Naturals, Sequences, TLC

Null == "null"

CONSTANTS
    Name,               \* STRING
    OriginDomainName,   \* STRING
    CertificateArn      \* STRING 또는 Null

Aliases == <<"www.example.com">>

Input == [
    name                |-> Name,
    origin_domain_name  |-> OriginDomainName,
    certificate_arn     |-> CertificateArn,
    aliases             |-> Aliases
]

\* main.tf의 lifecycle.precondition과 동일 — 커스텀 인증서인데 서빙할
\* 커스텀 도메인이 없으면 그 인증서는 존재할 이유가 없다.
Precondition(input) ==
    /\ input.name \in STRING /\ input.name # ""
    /\ input.origin_domain_name \in STRING /\ input.origin_domain_name # ""
    /\ input.certificate_arn \in STRING
    /\ (input.certificate_arn # Null => Len(input.aliases) > 0)

\* 1. CreateDistribution(origin=origin_domain_name, aliases,
\*    viewer_certificate: certificate_arn이 null이면 CloudFront 기본
\*    인증서 사용, 아니면 그 ACM 인증서 + SNI)
Provision(input) ==
    LET usesDefaultCert == input.certificate_arn = Null
    IN [
        domain_name       |-> input.name \o ".cloudfront.net",
        distribution_id   |-> "E" \o input.name,
        uses_default_cert |-> usesDefaultCert,
        ssl_support_method |-> IF usesDefaultCert THEN Null ELSE "sni-only"
    ]

\* 이게 이 스펙의 핵심: 기본 인증서 사용 여부는 정확히 certificate_arn이
\* null인지와 반대로 대응해야 한다 — 커스텀 인증서를 줬는데 기본
\* 인증서가 쓰이면 브라우저가 그 도메인에 대해 인증서 불일치 경고를
\* 띄운다.
Postcondition(input, output) ==
    /\ output.uses_default_cert = (input.certificate_arn = Null)
    /\ (~output.uses_default_cert => output.ssl_support_method = "sni-only")
    /\ (output.uses_default_cert => output.ssl_support_method = Null)

VARIABLES dummy
vars == <<dummy>>
Init == dummy = TRUE
Next == UNCHANGED dummy
Spec == Init /\ [][Next]_vars

BehaviorHolds == Precondition(Input) => Postcondition(Input, Provision(Input))

====
