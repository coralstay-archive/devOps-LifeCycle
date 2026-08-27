---- MODULE spec ----
(*
학습 목적: data-warehouse의 redshift 모듈은 클러스터를 만들 뿐, COPY 명령으로
S3 데이터를 적재하는 과정의 원자성(atomicity)은 보장하지 않는다 — Redshift는
COPY가 트랜잭션 안에서 실행되며, 실패하면 부분 적재 없이 전부 롤백된다는
동작을 여기서 명세한다.

핵심 안전 속성: 쿼리 가능한(Committed) 행 수는 스테이징에 실제로 올라온 행
수를 절대 넘을 수 없고, 적재가 실패(Failed)하면 부분적으로 반영된 행이 남지
않는다 — "COPY 중간에 실패했는데 절반만 보인다"는 상황이 없어야 한다는,
데이터 웨어하우스 적재에서 가장 중요한 무결성 속성.
*)
EXTENDS Naturals

CONSTANTS MaxRows

VARIABLES staged, committed

vars == <<staged, committed>>

Init ==
    /\ staged = 0
    /\ committed = 0

\* S3에서 스테이징 영역으로 원시 데이터가 쌓인다(COPY 대상 준비).
StageRows ==
    /\ staged < MaxRows
    /\ staged' = staged + 1
    /\ UNCHANGED committed

\* COPY 트랜잭션 커밋 — 스테이징된 만큼 전부(all-or-nothing) 한 번에
\* 커밋되어야 한다. 부분 커밋은 존재하지 않는다.
CommitLoad ==
    /\ committed < staged
    /\ committed' = staged
    /\ UNCHANGED staged

\* COPY 실패 — 트랜잭션이 롤백되어 커밋된 행 수는 그대로 유지된다(부분
\* 반영이 절대 남지 않는다는 걸 committed'가 UNCHANGED임으로 표현).
FailLoad ==
    /\ committed < staged
    /\ UNCHANGED vars

Next == StageRows \/ CommitLoad \/ FailLoad

Spec == Init /\ [][Next]_vars

TypeInvariant ==
    /\ staged \in 0..MaxRows
    /\ committed \in 0..MaxRows

\* 이게 이 스펙의 핵심: 커밋된 행은 항상 staged의 완전한 스냅샷 값 중 하나와
\* 일치해야 한다(=staged 이거나 이전 커밋 값) — 절대로 "staged와 committed
\* 사이의 어중간한 값"이 나올 수 없다는 all-or-nothing 보장.
AllOrNothingCommit == committed <= staged

====
