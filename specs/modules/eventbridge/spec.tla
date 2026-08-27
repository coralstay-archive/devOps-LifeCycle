---- MODULE spec ----
(*
학습 목적: main.tf가 이미 강제하는
"schedule_expression과 event_pattern 중 정확히 하나만"이라는 XOR
제약을 사전조건으로 다시 표현하고, target_is_lambda가 켜졌을 때만
Lambda invoke 권한이 부여된다는 분기를 후행조건으로 검증한다.

참고 문서:
- Amazon EventBridge API: PutRule, PutTargets
  — modules/eventbridge/README.md의 공식문서 절 참고
*)
EXTENDS Naturals, Sequences, TLC

Null == "null"

CONSTANTS
    Name,                 \* STRING
    ScheduleExpression,   \* STRING 또는 Null
    EventPattern,         \* STRING 또는 Null
    TargetArn,            \* STRING
    TargetIsLambda        \* BOOLEAN

Input == [
    name                  |-> Name,
    schedule_expression   |-> ScheduleExpression,
    event_pattern         |-> EventPattern,
    target_arn            |-> TargetArn,
    target_is_lambda      |-> TargetIsLambda
]

\* main.tf의 lifecycle.precondition과 동일한 XOR 제약 — 이 모듈이
\* 스스로 정한 스타일이 아니라, "둘 다 세팅됐을 때 EventBridge가 어느
\* 걸 따를지 불분명하다"는 실제 문제를 막는 것.
Precondition(input) ==
    /\ input.name \in STRING /\ input.name # ""
    /\ (input.schedule_expression # Null) # (input.event_pattern # Null)  \* XOR
    /\ input.target_arn \in STRING /\ input.target_arn # ""
    /\ input.target_is_lambda \in BOOLEAN

\* 1. PutRule(name, schedule_expression 또는 event_pattern 둘 중 하나)
\* 2. PutTargets(rule, [{arn: target_arn}])
\* 3. target_is_lambda면: AddPermission(target_arn, principal=events,
\*    source_arn=rule_arn) — 이 규칙 하나로만 scope된 호출 허가
Provision(input) ==
    [
        rule_arn                |-> "arn:aws:events:region:000000000000:rule/" \o input.name,
        is_schedule_based        |-> input.schedule_expression # Null,
        lambda_permission_granted |-> input.target_is_lambda
    ]

\* 이게 이 스펙의 핵심: Lambda 호출 권한은 target_is_lambda를 켰을
\* 때만, 그리고 정확히 그때만 부여되어야 한다 — 안 켰는데 권한을 주면
\* 최소 권한 원칙 위반이고, 켰는데 권한이 없으면 규칙이 있어도 대상이
\* 절대 호출되지 않는 조용한 실패다.
Postcondition(input, output) ==
    /\ output.lambda_permission_granted = input.target_is_lambda
    /\ output.is_schedule_based = (input.schedule_expression # Null)
    /\ output.rule_arn \in STRING

VARIABLES dummy
vars == <<dummy>>
Init == dummy = TRUE
Next == UNCHANGED dummy
Spec == Init /\ [][Next]_vars

BehaviorHolds == Precondition(Input) => Postcondition(Input, Provision(Input))

====
