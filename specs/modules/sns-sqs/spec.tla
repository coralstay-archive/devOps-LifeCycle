---- MODULE spec ----
(*
학습 목적: 핵심 동작은 main.tf 주석이 직접
짚는 바로 그것 — SQS 큐 정책의 ArnEquals 조건이 "이 특정 토픽"만
허용해야 하고, 다른 SNS 토픽은 이 큐에 못 쓰게 막아야 한다는 것.
와일드카드로 느슨해지면 계정 내 어떤 SNS 토픽이든 이 큐에 메시지를
넣을 수 있게 되는 보안 사고다.

참고 문서:
- Amazon SNS API: CreateTopic, Subscribe / Amazon SQS API: CreateQueue
  — modules/sns-sqs/README.md의 공식문서 절 참고
*)
EXTENDS Naturals, Sequences, TLC

CONSTANTS Name  \* STRING

Input == [name |-> Name]

Precondition(input) == input.name \in STRING /\ input.name # ""

\* 1. CreateTopic(name + "-topic")
\* 2. CreateQueue(name + "-queue")
\* 3. SetQueueAttributes(policy: Allow sns.amazonaws.com SendMessage
\*    WHERE ArnEquals(aws:SourceArn, topic_arn))  <- 이 토픽 ARN 하나로만 scope
\* 4. Subscribe(topic, protocol=sqs, endpoint=queue_arn, raw_message_delivery=true)
Provision(input) ==
    LET topicArn == "arn:aws:sns:region:000000000000:" \o input.name \o "-topic"
        queueArn == "arn:aws:sqs:region:000000000000:" \o input.name \o "-queue"
    IN [
        topic_arn                    |-> topicArn,
        queue_arn                    |-> queueArn,
        queue_url                    |-> input.name \o "-queue",
        \* 큐 정책이 실제로 허용하는 SourceArn 조건 값 — 이게 topic_arn과
        \* 정확히 같아야 한다는 게 이 모듈의 핵심 보안 동작.
        policy_allowed_source_arn    |-> topicArn,
        subscribed                   |-> TRUE,
        raw_message_delivery         |-> TRUE
    ]

\* 이게 이 스펙의 핵심: 큐 정책이 허용하는 SourceArn은 정확히 이 모듈이
\* 만든 토픽 하나뿐이어야 한다 — 다른 토픽의 ARN이나 와일드카드가
\* 아니어야 한다.
Postcondition(input, output) ==
    /\ output.policy_allowed_source_arn = output.topic_arn
    /\ output.subscribed = TRUE
    /\ output.raw_message_delivery = TRUE
    /\ output.queue_arn \in STRING

VARIABLES dummy
vars == <<dummy>>
Init == dummy = TRUE
Next == UNCHANGED dummy
Spec == Init /\ [][Next]_vars

BehaviorHolds == Precondition(Input) => Postcondition(Input, Provision(Input))

====
