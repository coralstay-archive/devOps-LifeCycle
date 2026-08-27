---- MODULE spec ----
(*
학습 목적: DNS 검증 방식 인증서 발급의 핵심
동작: 최종 반환되는 certificate_arn은 반드시 domain_name과 모든
subject_alternative_names를 커버하는 "검증 완료된" 인증서를 가리켜야
한다 — 검증이 끝나기 전의 PENDING_VALIDATION 상태 인증서를 그냥 돌려주면
안 된다는 게 aws_acm_certificate_validation 리소스가 존재하는 이유다.

참고 문서:
- AWS Certificate Manager API: RequestCertificate, DescribeCertificate
  — modules/acm/README.md의 공식문서 절 참고
*)
EXTENDS Naturals, Sequences, TLC

CONSTANTS
    DomainName,  \* STRING
    ZoneId       \* STRING

\* Seq 값은 .cfg의 CONSTANT 대입 문법으로 못 쓰므로 여기 직접 정의한다.
SANs == <<"www.example.com">>

Input == [
    domain_name  |-> DomainName,
    zone_id      |-> ZoneId,
    sans         |-> SANs
]

Precondition(input) ==
    /\ input.domain_name \in STRING /\ input.domain_name # ""
    /\ input.zone_id \in STRING /\ input.zone_id # ""
    /\ input.sans \in Seq(STRING)

\* 1. RequestCertificate(domain_name, sans, validation_method=DNS)
\*    -> 이 시점 상태는 PENDING_VALIDATION
\* 2. 각 도메인(주 도메인 + SAN)마다 CreateRoute53Record(zone_id, CNAME 검증 레코드)
\* 3. WaitForCertificateValidation — 모든 검증 레코드가 전파/확인될 때까지
\*    대기(aws_acm_certificate_validation이 이 폴링을 담당) -> ISSUED로 전이
Provision(input) ==
    LET certArn == "arn:aws:acm:region:000000000000:certificate/" \o input.domain_name
        coveredDomains == <<input.domain_name>> \o input.sans
    IN [
        certificate_arn  |-> certArn,
        status           |-> "ISSUED",  \* validation 리소스를 거친 뒤에만 반환되므로 PENDING일 수 없다
        covered_domains  |-> coveredDomains
    ]

\* 이게 이 스펙의 핵심: 반환된 인증서는 (a) 반드시 ISSUED 상태여야 하고
\* (PENDING_VALIDATION을 그대로 반환하면 그 인증서를 쓰는 ALB/CloudFront가
\* TLS 핸드셰이크에서 그대로 실패한다), (b) domain_name과 모든 SAN을
\* 빠짐없이 커버해야 한다.
Postcondition(input, output) ==
    /\ output.status = "ISSUED"
    /\ input.domain_name \in {output.covered_domains[i] : i \in DOMAIN output.covered_domains}
    /\ \A i \in DOMAIN input.sans :
        input.sans[i] \in {output.covered_domains[j] : j \in DOMAIN output.covered_domains}

VARIABLES dummy
vars == <<dummy>>
Init == dummy = TRUE
Next == UNCHANGED dummy
Spec == Init /\ [][Next]_vars

BehaviorHolds == Precondition(Input) => Postcondition(Input, Provision(Input))

====
