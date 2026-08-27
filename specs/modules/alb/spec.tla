---- MODULE spec ----
(*
학습 목적: 이 모듈의 진짜 동작은
certificate_arn의 유무에 따라 "외부에 노출되는 리스너"가 완전히 달라진다는
것이다 — 인증서가 없으면 HTTP 리스너가 직접 트래픽을 포워딩하고, 있으면
HTTP는 오직 HTTPS로 리다이렉트만 하고 실제 포워딩은 HTTPS 리스너가 한다.
listener_arn 출력이 항상 "실제로 트래픽을 포워딩하는" 리스너를 가리켜야
한다는 게 이 모듈의 핵심 후행조건이다.

참고 문서:
- Elastic Load Balancing API: CreateLoadBalancer, CreateTargetGroup,
  CreateListener — modules/alb/README.md의 공식문서 절 참고
*)
EXTENDS Naturals, Sequences, TLC

Null == "null"

CONSTANTS
    Name,             \* STRING
    VpcId,            \* STRING
    TargetPort,       \* Nat
    CertificateArn    \* STRING 또는 Null

Input == [
    name             |-> Name,
    vpc_id           |-> VpcId,
    target_port      |-> TargetPort,
    certificate_arn  |-> CertificateArn
]

Precondition(input) ==
    /\ input.name \in STRING
    /\ input.vpc_id \in STRING /\ input.vpc_id # ""
    /\ input.target_port \in Nat
    /\ input.certificate_arn \in STRING

\* 1. CreateSecurityGroup + 인그레스(80, 443 조건부)/이그레스 규칙
\* 2. CreateLoadBalancer(subnets, sg)
\* 3. CreateTargetGroup(vpc_id, target_port)
\* 4. CreateListener(80): certificate_arn = null이면 forward, 아니면 리다이렉트
\* 5. certificate_arn # null이면 CreateListener(443, cert) — forward
Provision(input) ==
    LET httpListenerArn == "arn:aws:elasticloadbalancing:listener/http/" \o input.name
        httpsListenerArn == "arn:aws:elasticloadbalancing:listener/https/" \o input.name
        hasCert == input.certificate_arn # Null
    IN [
        dns_name           |-> input.name \o ".elb.amazonaws.com",
        target_group_arn   |-> "arn:aws:elasticloadbalancing:targetgroup/" \o input.name,
        security_group_id  |-> "sg-" \o input.name,
        \* 이게 이 스펙의 핵심 계산: 인증서 유무에 따라 어떤 리스너가
        \* "실제로 포워딩하는 리스너"인지가 바뀐다.
        listener_arn        |-> IF hasCert THEN httpsListenerArn ELSE httpListenerArn,
        http_listener_forwards |-> ~hasCert  \* HTTP가 직접 포워딩하는지(=인증서 없을 때만)
    ]

\* listener_arn은 항상 "실제로 포워딩하는" 리스너를 가리켜야 한다 —
\* 인증서가 있는데 listener_arn이 http를 가리키면, 그건 트래픽이 그냥
\* 리다이렉트만 되는 리스너를 외부 노출 엔드포인트로 잘못 알려주는
\* 심각한 버그다(예: 헬스체크나 DNS가 이 값을 그대로 쓴다고 하면).
Postcondition(input, output) ==
    LET hasCert == input.certificate_arn # Null IN
    /\ (hasCert => output.listener_arn = ("arn:aws:elasticloadbalancing:listener/https/" \o input.name))
    /\ (~hasCert => output.listener_arn = ("arn:aws:elasticloadbalancing:listener/http/" \o input.name))
    /\ output.http_listener_forwards = ~hasCert

VARIABLES dummy
vars == <<dummy>>
Init == dummy = TRUE
Next == UNCHANGED dummy
Spec == Init /\ [][Next]_vars

BehaviorHolds == Precondition(Input) => Postcondition(Input, Provision(Input))

====
