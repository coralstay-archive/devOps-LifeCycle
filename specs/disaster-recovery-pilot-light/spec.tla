---- MODULE spec ----
(*
학습 목적: disaster-recovery-pilot-light는 DR 리전에 최소한의 리소스만
(예: RDS 읽기 복제본, 축소된 ASG) 켜둔 채로 대기하다가, 주 리전 장애 시
용량을 스케일업해 전체 서비스로 전환한다. Terraform은 "이런 리소스가
있다"고만 선언하지, 전환(failover)이 올바른 순서(복제본 승격 -> 용량
확장 -> 트래픽 전환)로만 일어난다는 보장은 런타임의 몫이다 — 그 순서를
여기서 명세한다.

핵심 안전 속성: DNS/트래픽이 DR 리전으로 전환(TrafficSwitched)되는 시점에는
반드시 그 전에 복제본 승격(Promoted)과 용량 확장(ScaledUp)이 끝나 있어야
한다 — 용량도 없는 pilot-light 상태로 트래픽을 받아버리는 장애를 막는다.
*)
EXTENDS Naturals

VARIABLES promoted, scaledUp, trafficSwitched

vars == <<promoted, scaledUp, trafficSwitched>>

Init ==
    /\ promoted = FALSE
    /\ scaledUp = FALSE
    /\ trafficSwitched = FALSE

\* 1단계: DR 리전의 읽기 복제본을 쓰기 가능한 primary로 승격시킨다.
PromoteReplica ==
    /\ promoted = FALSE
    /\ promoted' = TRUE
    /\ UNCHANGED <<scaledUp, trafficSwitched>>

\* 2단계: 승격이 끝난 뒤에야 축소되어 있던 컴퓨트 용량을 실제 트래픽을
\* 받을 수 있는 크기로 확장한다.
ScaleUpCapacity ==
    /\ promoted = TRUE
    /\ scaledUp = FALSE
    /\ scaledUp' = TRUE
    /\ UNCHANGED <<promoted, trafficSwitched>>

\* 3단계: 승격과 용량 확장이 모두 끝난 뒤에야 Route53 등을 통해 실제 트래픽을
\* DR 리전으로 전환한다.
SwitchTraffic ==
    /\ promoted = TRUE
    /\ scaledUp = TRUE
    /\ trafficSwitched = FALSE
    /\ trafficSwitched' = TRUE
    /\ UNCHANGED <<promoted, scaledUp>>

Next == PromoteReplica \/ ScaleUpCapacity \/ SwitchTraffic

Spec == Init /\ [][Next]_vars

TypeInvariant ==
    /\ promoted \in BOOLEAN
    /\ scaledUp \in BOOLEAN
    /\ trafficSwitched \in BOOLEAN

\* 이게 이 스펙의 핵심: 트래픽이 전환됐다면 승격과 용량 확장은 반드시 이미
\* 끝나 있어야 한다 — 순서를 건너뛰는 경로가 Next에 없다는 것으로 보장.
NoTrafficBeforeReady == trafficSwitched => (promoted /\ scaledUp)

====
