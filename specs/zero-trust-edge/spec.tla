---- MODULE spec ----
(*
학습 목적: zero-trust-edge의 waf-shield 모듈은 WAF Web ACL을 ALB/CloudFront
앞단에 연결한다. "연결되어 있다"는 Terraform 상태와 "모든 요청이 실제로
WAF 검사를 통과해야만 오리진에 도달한다"는 런타임 보장은 다른 이야기다 —
후자를 여기서 명세한다.

핵심 안전 속성: 오리진에 도달(ReachedOrigin)한 요청은 반드시 그 전에 WAF
검사(Inspected)를 통과한 것이어야 한다 — WAF를 우회해서 오리진에 직접
도달하는 경로가 있으면 안 된다는, 제로 트러스트 엣지의 핵심 전제.
*)
EXTENDS Naturals

VARIABLES inspected, reachedOrigin, blocked

vars == <<inspected, reachedOrigin, blocked>>

Init ==
    /\ inspected = FALSE
    /\ reachedOrigin = FALSE
    /\ blocked = FALSE

\* 요청이 WAF Web ACL의 규칙 평가를 통과한다(정상 요청).
InspectAndAllow ==
    /\ inspected = FALSE
    /\ inspected' = TRUE
    /\ UNCHANGED <<reachedOrigin, blocked>>

\* 요청이 WAF 규칙(예: SQLi 패턴, rate-based rule)에 의해 차단된다 —
\* 이 경로는 절대 오리진에 도달하지 않는다.
InspectAndBlock ==
    /\ inspected = FALSE
    /\ inspected' = TRUE
    /\ blocked' = TRUE
    /\ UNCHANGED reachedOrigin

\* WAF 검사를 통과(허용)한 요청만 ALB/CloudFront 뒤의 실제 오리진으로
\* 전달된다.
ForwardToOrigin ==
    /\ inspected = TRUE
    /\ blocked = FALSE
    /\ reachedOrigin' = TRUE
    /\ UNCHANGED <<inspected, blocked>>

Next == InspectAndAllow \/ InspectAndBlock \/ ForwardToOrigin

Spec == Init /\ [][Next]_vars

TypeInvariant ==
    /\ inspected \in BOOLEAN
    /\ reachedOrigin \in BOOLEAN
    /\ blocked \in BOOLEAN

\* 이게 이 스펙의 핵심: 오리진에 도달했다면 반드시 검사를 통과했고, 차단되지
\* 않았어야 한다 — WAF를 우회하는 경로가 Next에 존재하지 않는다는 것으로
\* 구조적으로 보장.
NoBypassingWAF == reachedOrigin => (inspected /\ ~blocked)

====
