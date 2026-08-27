---- MODULE spec ----
(*
학습 목적: multi-region-active-active는 두 리전에 동일한 스택을 배포하고
데이터를 비동기 복제(예: DynamoDB Global Tables, Aurora Global Database)한다.
"비동기"라는 말은 곧 복제 지연(replication lag)이 있다는 뜻이고, 리전 A에
쓴 데이터가 리전 B에 아직 안 갔을 수도 있다는 뜻이다 — 그 지연과, 그럼에도
"결국은 복제된다"는 보장을 여기서 명세한다.

핵심 안전 속성: 리전 A에 쓰인 모든 데이터는 결국(eventually) 리전 B에도
복제된다 — 복제가 영원히 지연되어 데이터가 소실된 것처럼 보이는 상황이
없다는 것(최종적 일관성, eventual consistency).
*)
EXTENDS Naturals

CONSTANTS MaxWrites

VARIABLES writtenInA, replicatedToB

vars == <<writtenInA, replicatedToB>>

Init ==
    /\ writtenInA = 0
    /\ replicatedToB = 0

\* 애플리케이션이 리전 A(자기와 가장 가까운 리전)에 쓴다 — active-active이므로
\* 어느 리전에 써도 되지만, 여기서는 A 방향의 복제만 단순화해서 모델링한다.
WriteInA ==
    /\ writtenInA < MaxWrites
    /\ writtenInA' = writtenInA + 1
    /\ UNCHANGED replicatedToB

\* 비동기 복제 파이프라인이 아직 안 간 데이터를 리전 B로 흘려보낸다 —
\* 이 액션이 즉시 일어나지 않아도(지연되어도) 괜찮다는 게 핵심.
ReplicateToB ==
    /\ replicatedToB < writtenInA
    /\ replicatedToB' = replicatedToB + 1
    /\ UNCHANGED writtenInA

Next == WriteInA \/ ReplicateToB

\* 복제가 영원히 멈추지 않는다는 공정성 가정 — 실제로는 리전 간 네트워크
\* 링크가 살아있는 한 복제 파이프라인은 계속 진행된다는 걸 모델링.
Spec == Init /\ [][Next]_vars /\ WF_vars(WriteInA) /\ WF_vars(ReplicateToB)

TypeInvariant ==
    /\ writtenInA \in 0..MaxWrites
    /\ replicatedToB \in 0..MaxWrites

\* 복제된 양이 쓰인 양을 앞지를 수는 없다(당연한 순서 제약).
NoOverReplication == replicatedToB <= writtenInA

\* 이게 이 스펙의 핵심 활성 속성: A에 쓰인 만큼은 결국 B에도 복제된다 —
\* 복제 지연은 있어도 되지만 영구 데이터 손실은 없다는 보장.
EventuallyFullyReplicated == (writtenInA = MaxWrites) ~> (replicatedToB = MaxWrites)

====
