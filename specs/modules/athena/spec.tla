---- MODULE spec ----
(*
학습 목적: 이 모듈의 동작은 단순하지만
중요하다 — 워크그룹의 쿼리 결과 저장 위치(output_location)가 정확히
입력받은 S3 경로와 일치해야 한다. 다르면 쿼리 결과가 엉뚱한 버킷에
쌓여 비용/거버넌스 문제가 된다.

참고 문서:
- Amazon Athena API: CreateWorkGroup
  — modules/athena/README.md의 공식문서 절 참고
*)
EXTENDS Naturals, Sequences, TLC

CONSTANTS
    Name,           \* STRING
    OutputLocation  \* STRING, s3:// 경로

Input == [
    name             |-> Name,
    output_location  |-> OutputLocation
]

Precondition(input) ==
    /\ input.name \in STRING /\ input.name # ""
    /\ input.output_location \in STRING
    /\ Len(input.output_location) >= 5 /\ SubSeq(input.output_location, 1, 5) = "s3://"

\* 1. CreateWorkGroup(name, result_configuration.output_location)
Provision(input) ==
    [
        workgroup_name          |-> input.name,
        effective_output_location |-> input.output_location
    ]

Postcondition(input, output) ==
    /\ output.effective_output_location = input.output_location
    /\ output.workgroup_name = input.name

VARIABLES dummy
vars == <<dummy>>
Init == dummy = TRUE
Next == UNCHANGED dummy
Spec == Init /\ [][Next]_vars

BehaviorHolds == Precondition(Input) => Postcondition(Input, Provision(Input))

====
