---- MODULE spec ----
(*
학습 목적: pub-sub-fanout의 sns-sqs 모듈은 SNS 토픽에 여러 SQS 큐를
구독시켜 "팬아웃"을 구성한다. SNS가 실제로 보장하는 건 "발행된 메시지는
발행 시점에 구독 중이던 모든 큐에 각각 전달된다"는 것이다 — 일부 구독자만
받고 나머지는 못 받는 상황은 없어야 한다는 그 동작을 여기서 명세한다.

핵심 안전 속성: 메시지가 발행(Published)되면, 그 시점의 모든 구독자는
결국(eventually) 각자의 큐로 그 메시지를 받는다 — 한 구독자만 받고 다른
구독자는 영원히 못 받는(fanout이 일부만 성공하는) 상황이 없다는 것.
*)
EXTENDS Naturals

CONSTANTS Subscribers

VARIABLES published, received

vars == <<published, received>>

Init ==
    /\ published = FALSE
    /\ received = [s \in Subscribers |-> FALSE]

\* 퍼블리셔가 토픽에 메시지를 한 번 발행한다.
Publish ==
    /\ published = FALSE
    /\ published' = TRUE
    /\ UNCHANGED received

\* SNS가 구독자 s의 큐로 메시지를 전달한다 — 각 구독자는 독립적으로,
\* 서로 다른 시점에 전달받을 수 있다(팬아웃은 동시 전달을 보장하지 않고
\* "결국 전부에게 전달됨"만 보장한다).
DeliverTo(s) ==
    /\ published = TRUE
    /\ received[s] = FALSE
    /\ received' = [received EXCEPT ![s] = TRUE]
    /\ UNCHANGED published

Next == Publish \/ (\E s \in Subscribers : DeliverTo(s))

\* 활성 속성(liveness)을 의미 있게 검증하려면 "언젠가는 반드시 일어난다"는
\* 공정성(fairness) 가정이 필요하다 — 그렇지 않으면 시스템이 영원히
\* stutter(제자리걸음)해도 스펙을 위반하지 않는 것으로 처리되어 검증이
\* 무의미해진다. SNS/SQS의 실제 전달 재시도 동작을 약한 공정성(WF)으로
\* 모델링한다.
Spec == Init /\ [][Next]_vars /\ WF_vars(Publish) /\ \A s \in Subscribers : WF_vars(DeliverTo(s))

TypeInvariant ==
    /\ published \in BOOLEAN
    /\ received \in [Subscribers -> BOOLEAN]

\* 발행되지 않았다면 어떤 구독자도 아직 메시지를 받았을 리 없다 — 팬아웃이
\* 존재하지도 않는 메시지를 만들어내지 않는다는 안전 속성.
NoReceiveBeforePublish == (\E s \in Subscribers : received[s]) => published

\* 모든 구독자가 결국 메시지를 받는다는 활성 속성(liveness) — Publish 이후
\* 시스템이 계속 진행되면 모든 구독자의 received가 TRUE가 되어야 한다.
EventuallyAllReceive == published ~> (\A s \in Subscribers : received[s])

====
