---- MODULE spec ----
(*
학습 목적: ml-realtime-inference의 sagemaker 엔드포인트는 모델을 새 버전으로
갱신할 때 기존 인스턴스를 먼저 내리고 새 걸 올리는 게 아니라, 새 인스턴스
그룹을 먼저 띄우고 트래픽을 전환한 뒤에야 이전 인스턴스를 내린다
(blue/green 업데이트). 이걸 반대로 하면(먼저 내리고 나중에 올리면) 무중단
배포가 깨진다 — 그 순서 제약을 여기서 명세한다.

핵심 안전 속성: 새 인스턴스(green)가 준비(Ready)되기 전까지는 기존
인스턴스(blue)를 절대 내리지 않는다 — 어느 시점에도 "서빙 가능한 인스턴스가
0개"인 순간이 없다는, 무중단 배포의 핵심 보장.
*)
EXTENDS Naturals

VARIABLES blueUp, greenUp

vars == <<blueUp, greenUp>>

Init ==
    /\ blueUp = TRUE
    /\ greenUp = FALSE

\* 새 모델 버전을 실은 green 인스턴스 그룹을 먼저 띄운다 — 이 시점엔 blue도
\* 여전히 트래픽을 받고 있다(둘 다 떠 있는 과도기).
StartGreen ==
    /\ greenUp = FALSE
    /\ greenUp' = TRUE
    /\ UNCHANGED blueUp

\* green이 헬스체크를 통과해 트래픽을 받을 준비가 된 뒤에야, 이제 필요 없는
\* blue 인스턴스를 내린다.
RetireBlue ==
    /\ greenUp = TRUE
    /\ blueUp = TRUE
    /\ blueUp' = FALSE
    /\ UNCHANGED greenUp

Next == StartGreen \/ RetireBlue

Spec == Init /\ [][Next]_vars

TypeInvariant ==
    /\ blueUp \in BOOLEAN
    /\ greenUp \in BOOLEAN

\* 이게 이 스펙의 핵심: 언제나 blue 또는 green 중 최소 하나는 떠 있어야
\* 한다 — 서빙 용량이 0이 되는 순간이 없어야 무중단 배포다.
NeverZeroCapacity == blueUp \/ greenUp

====
