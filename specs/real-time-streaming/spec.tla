---- MODULE spec ----
(*
학습 목적: real-time-streaming의 msk-kafka 모듈은 "브로커와 토픽을 만들라"고만
선언한다. 실제로 프로듀서가 쓴 메시지를 컨슈머가 순서대로, 한 번도 건너뛰지
않고 읽어간다는 보장(파티션 내 순서 보장 + 컨슈머 오프셋 커밋)은 Kafka의
런타임 동작이지 Terraform 코드가 아니다 — 그 동작을 여기서 명세한다.

핵심 안전 속성: 컨슈머 오프셋(consumed)은 절대 프로듀서가 실제로 쓴 메시지 수
(produced)를 앞지를 수 없다 — "아직 쓰이지 않은 메시지를 읽었다"는 상황은
파티션 순서 보장이 있는 한 물리적으로 불가능해야 한다.
*)
EXTENDS Naturals

CONSTANTS MaxMessages

VARIABLES produced, consumed

vars == <<produced, consumed>>

Init ==
    /\ produced = 0
    /\ consumed = 0

\* 프로듀서가 파티션에 메시지를 하나 append한다 — 항상 로그 끝에 순차적으로
\* 쓰인다는 Kafka 파티션의 append-only 특성을 모델링.
Produce ==
    /\ produced < MaxMessages
    /\ produced' = produced + 1
    /\ UNCHANGED consumed

\* 컨슈머는 자신의 오프셋보다 앞선(즉 아직 안 읽은) 메시지가 있을 때만 읽고
\* 커밋할 수 있다 — 커밋된 오프셋은 "여기까지 읽었다"는 컨슈머 그룹의 진행
\* 상태(consumer group offset)를 뜻한다.
Consume ==
    /\ consumed < produced
    /\ consumed' = consumed + 1
    /\ UNCHANGED produced

Next == Produce \/ Consume

Spec == Init /\ [][Next]_vars

TypeInvariant ==
    /\ produced \in 0..MaxMessages
    /\ consumed \in 0..MaxMessages

\* 이게 이 스펙의 핵심: 컨슈머는 프로듀서가 실제로 쓴 것보다 더 많이 읽을 수
\* 없다 — 파티션 순서 보장이 깨지면(예: 리밸런싱 버그) 이 불변식이 위반된다.
NoReadingUnwrittenMessages == consumed <= produced

====
