---- MODULE spec ----
(*
학습 목적: 이 모듈이 실행 역할(IAM Role)을
항상 자체적으로 만든다는 것, 그리고 invoke_arn이 function_arn으로부터
파생된 값(API Gateway 등이 실제로 호출할 때 쓰는 형태)이라는 관계가
핵심 동작이다.

참고 문서:
- AWS Lambda API: CreateFunction — modules/lambda/README.md의 공식문서 절 참고
*)
EXTENDS Naturals, Sequences, TLC

CONSTANTS
    FunctionName,  \* STRING
    Runtime,       \* STRING
    MemorySize,    \* Nat
    Timeout        \* Nat

Input == [
    function_name  |-> FunctionName,
    runtime        |-> Runtime,
    memory_size    |-> MemorySize,
    timeout        |-> Timeout
]

Precondition(input) ==
    /\ input.function_name \in STRING /\ input.function_name # ""
    /\ input.runtime \in STRING
    /\ input.memory_size \in 128..10240   \* Lambda API가 실제로 허용하는 메모리 범위
    /\ input.timeout \in 1..900           \* Lambda API가 실제로 허용하는 최대 타임아웃(15분)

\* 1. CreateRole(function_name + "-role", trust=lambda.amazonaws.com)
\* 2. AttachRolePolicy(role, AWSLambdaBasicExecutionRole 상당)
\* 3. CreateFunction(function_name, runtime, role_arn, memory_size, timeout)
Provision(input) ==
    LET roleArn == "arn:aws:iam::000000000000:role/" \o input.function_name \o "-role"
        functionArn == "arn:aws:lambda:region:000000000000:function:" \o input.function_name
    IN [
        function_name  |-> input.function_name,
        function_arn   |-> functionArn,
        \* API Gateway 등이 실제로 호출할 때 쓰는 형태 — function_arn과는
        \* 다른 문자열이지만 항상 그로부터 파생된다.
        invoke_arn     |-> "arn:aws:apigateway:region:lambda:path/2015-03-31/functions/" \o functionArn \o "/invocations",
        role_arn       |-> roleArn
    ]

\* 이게 이 스펙의 핵심: invoke_arn은 항상 function_arn을 포함하는 형태여야
\* 한다(둘이 서로 다른 함수를 가리키면 API Gateway가 엉뚱한 함수를
\* 호출하게 된다) — 그리고 role_arn은 항상 이 함수 전용 역할이어야
\* 한다(다른 함수와 실행 역할을 공유하면 최소 권한 원칙이 깨진다).
Postcondition(input, output) ==
    /\ \E i \in 1..(Len(output.invoke_arn) - Len(output.function_arn) + 1) :
        SubSeq(output.invoke_arn, i, i + Len(output.function_arn) - 1) = output.function_arn
    /\ output.role_arn = ("arn:aws:iam::000000000000:role/" \o input.function_name \o "-role")

VARIABLES dummy
vars == <<dummy>>
Init == dummy = TRUE
Next == UNCHANGED dummy
Spec == Init /\ [][Next]_vars

BehaviorHolds == Precondition(Input) => Postcondition(Input, Provision(Input))

====
