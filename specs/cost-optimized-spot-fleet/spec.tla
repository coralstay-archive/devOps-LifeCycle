---- MODULE spec ----
(*
학습 목적: cost-optimized-spot-fleet은 ec2/eks 모듈을 Spot 인스턴스로
구성해 비용을 아낀다. Spot의 핵심 트레이드오프는 AWS가 용량을 회수할 때
정확히 2분(120초)의 인터럽션 경고(Spot Interruption Notice)만 주고
종료한다는 것 — 그 2분 안에 대체 인스턴스를 확보하지 못하면 순간적으로
용량이 줄어든다. Karpenter/ASG의 인터럽션 핸들러가 이 경고를 받아 즉시
대체 노드를 요청하는 동작을 여기서 명세한다.

핵심 안전 속성: 인터럽션 경고(NoticeReceived)를 받은 뒤에는, 실제 종료
(Terminated)가 일어나기 전에 반드시 대체 노드 확보 시도(ReplacementRequested)가
있어야 한다 — 아무 대응 없이 그냥 용량이 사라지는 상황을 막는다.
*)
EXTENDS Naturals

VARIABLES phase, terminatedWithoutReplacement

vars == <<phase, terminatedWithoutReplacement>>

Phases == {"Running", "NoticeReceived", "ReplacementRequested", "Terminated"}

Init ==
    /\ phase = "Running"
    /\ terminatedWithoutReplacement = FALSE

\* AWS가 Spot 용량을 회수하기로 결정하고 2분 전 인터럽션 경고를 보낸다.
ReceiveInterruptionNotice ==
    /\ phase = "Running"
    /\ phase' = "NoticeReceived"
    /\ UNCHANGED terminatedWithoutReplacement

\* Karpenter/ASG 인터럽션 핸들러가 경고를 감지하자마자 대체 노드를
\* 요청한다(On-Demand로 폴백하거나 다른 Spot 풀에서 확보).
RequestReplacement ==
    /\ phase = "NoticeReceived"
    /\ phase' = "ReplacementRequested"
    /\ UNCHANGED terminatedWithoutReplacement

\* 2분이 지나 실제로 인스턴스가 종료된다 — 이 시점에는 이미 대체 노드
\* 요청이 나가 있어야 정상이다.
Terminate ==
    /\ phase = "ReplacementRequested"
    /\ phase' = "Terminated"
    /\ UNCHANGED terminatedWithoutReplacement

\* 의도적으로 Next에 포함하지 않은 "버그" 액션 — 대체 노드 요청 없이 경고
\* 직후 바로 종료로 넘어가는 경로(인터럽션 핸들러가 없거나 고장난 경우).
\* TerminateWithoutReplacement ==
\*     /\ phase = "NoticeReceived"
\*     /\ phase' = "Terminated"
\*     /\ terminatedWithoutReplacement' = TRUE

Next == ReceiveInterruptionNotice \/ RequestReplacement \/ Terminate

Spec == Init /\ [][Next]_vars

TypeInvariant ==
    /\ phase \in Phases
    /\ terminatedWithoutReplacement \in BOOLEAN

NoTerminationWithoutReplacement == terminatedWithoutReplacement = FALSE

====
