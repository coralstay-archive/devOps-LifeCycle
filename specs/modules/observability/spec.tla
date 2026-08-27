---- MODULE spec ----
(*
학습 목적: alarm_email이 null이면 SNS
토픽은 만들어지지만 구독자가 없다 — 알람이 울려도 아무도 못 받는
상태다. 이건 버그는 아니지만(Slack/PagerDuty를 나중에 따로 연결할 수
있으므로), "구독자 없는 알람 토픽"이라는 상태를 명시적으로 드러내는 게
이 스펙의 목적이다.

참고 문서:
- Amazon SNS API: CreateTopic, Subscribe / Amazon CloudWatch API: PutDashboard
  — modules/observability/README.md의 공식문서 절 참고
*)
EXTENDS Naturals, Sequences, TLC

Null == "null"

CONSTANTS
    Name,         \* STRING
    AlarmEmail    \* STRING 또는 Null

Input == [
    name         |-> Name,
    alarm_email  |-> AlarmEmail
]

Precondition(input) ==
    /\ input.name \in STRING /\ input.name # ""
    /\ input.alarm_email \in STRING

\* 1. CreateTopic(name) -> alarm_topic_arn
\* 2. alarm_email # null이면: Subscribe(topic, "email", alarm_email)
\* 3. PutDashboard(name) -> dashboard_name
Provision(input) ==
    [
        alarm_topic_arn   |-> "arn:aws:sns:region:000000000000:" \o input.name \o "-alarms",
        dashboard_name    |-> input.name \o "-dashboard",
        has_subscriber    |-> input.alarm_email # Null
    ]

\* 이게 이 스펙의 핵심: 토픽과 대시보드는 alarm_email 유무와 무관하게
\* 항상 존재해야 하고(알람 자체는 항상 평가되어야 하므로), has_subscriber는
\* 정확히 alarm_email이 주어졌는지와 일치해야 한다 — "이메일을 줬는데
\* 구독이 안 걸렸다"거나 "안 줬는데 구독이 걸렸다"는 상황이 없어야 한다.
Postcondition(input, output) ==
    /\ output.alarm_topic_arn \in STRING
    /\ output.dashboard_name \in STRING
    /\ output.has_subscriber = (input.alarm_email # Null)

VARIABLES dummy
vars == <<dummy>>
Init == dummy = TRUE
Next == UNCHANGED dummy
Spec == Init /\ [][Next]_vars

BehaviorHolds == Precondition(Input) => Postcondition(Input, Provision(Input))

====
