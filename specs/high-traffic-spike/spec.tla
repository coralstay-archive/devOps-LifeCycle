---- MODULE spec ----
(*
학습 목적: high-traffic-spike의 핵심 약속은 "부하가 튀면 EKS 노드가 빠르게
늘어난다"(Karpenter)는 것이다. Terraform은 노드그룹의 min/max 범위만 선언할
뿐, 부하와 노드 수가 시간에 따라 어떻게 맞물려 움직이는지는 설명하지 않는다
— 그 동적 관계를 여기서 명세한다.

핵심 안전 속성: 시스템은 절대 "과부하인데 스케일업할 자원도 없는" 상태에
영원히 머무르지 않는다 — 정확히는, load > capacity인 상태에서 반드시
ScaleUp 액션이 활성화되어 있어야 한다(스터터링만 유일한 선택지가 되는 게
아니어야 한다는 뜻).
*)
EXTENDS Naturals

CONSTANTS MaxNodes, CapacityPerNode

VARIABLES load, nodes

vars == <<load, nodes>>

capacity == nodes * CapacityPerNode

Init ==
    /\ load = 0
    /\ nodes = 1

\* 트래픽 스파이크: 부하가 갑자기 튄다 (Karpenter가 반응해야 하는 트리거).
LoadSpike ==
    /\ load < MaxNodes * CapacityPerNode
    /\ load' = load + CapacityPerNode
    /\ UNCHANGED nodes

\* Karpenter가 노드를 하나 더 프로비저닝한다 — load가 이미 capacity를
\* 넘어섰을 때만 트리거된다는 게 "과잉 프로비저닝하지 않는다"는 실제 의도를
\* 반영한다.
ScaleUp ==
    /\ load > capacity
    /\ nodes < MaxNodes
    /\ nodes' = nodes + 1
    /\ UNCHANGED load

\* 부하가 가라앉으면 스케일다운(노드 회수)도 일어난다.
LoadDrop ==
    /\ load > 0
    /\ load' = load - CapacityPerNode
    /\ UNCHANGED nodes

ScaleDown ==
    /\ nodes > 1
    /\ capacity - CapacityPerNode >= load
    /\ nodes' = nodes - 1
    /\ UNCHANGED load

Next == LoadSpike \/ ScaleUp \/ LoadDrop \/ ScaleDown

Spec == Init /\ [][Next]_vars

TypeInvariant ==
    /\ load \in 0..(MaxNodes * CapacityPerNode)
    /\ nodes \in 1..MaxNodes

\* 노드 수가 절대 MaxNodes를 넘지 않는다는 것 자체도 검증 대상이다 —
\* Karpenter 설정 실수로 상한이 안 걸리면 비용이 무한정 늘어날 수 있다.
BoundedNodes == nodes <= MaxNodes
====
