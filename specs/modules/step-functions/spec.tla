---- MODULE spec ----
(*
학습 목적: 이 모듈의 동작은 단순하다 —
policy_arns로 넘긴 권한 개수만큼 실행 역할에 정책이 붙어야 하고,
role_arn과 state_machine_arn은 항상 함께 나와야 한다(상태 머신은 역할
없이 아무 것도 실행할 수 없다).

참고 문서:
- AWS Step Functions API: CreateStateMachine
  — modules/step-functions/README.md의 공식문서 절 참고
*)
EXTENDS Naturals, Sequences, TLC

CONSTANTS Name  \* STRING

PolicyArns == <<"arn:aws:iam::aws:policy/AWSLambdaRole">>

Input == [
    name         |-> Name,
    policy_arns  |-> PolicyArns
]

Precondition(input) ==
    /\ input.name \in STRING /\ input.name # ""
    /\ input.policy_arns \in Seq(STRING)

\* 1. CreateRole(name + "-role", trust=states.amazonaws.com)
\* 2. policy_arns 각각에 대해 AttachRolePolicy
\* 3. CreateStateMachine(name, definition, role_arn)
Provision(input) ==
    [
        role_arn            |-> "arn:aws:iam::000000000000:role/" \o input.name \o "-role",
        state_machine_arn   |-> "arn:aws:states:region:000000000000:stateMachine:" \o input.name,
        attached_policy_count |-> Len(input.policy_arns)
    ]

Postcondition(input, output) ==
    /\ output.attached_policy_count = Len(input.policy_arns)
    /\ output.role_arn \in STRING
    /\ output.state_machine_arn \in STRING

VARIABLES dummy
vars == <<dummy>>
Init == dummy = TRUE
Next == UNCHANGED dummy
Spec == Init /\ [][Next]_vars

BehaviorHolds == Precondition(Input) => Postcondition(Input, Provision(Input))

====
