---- MODULE spec ----
(*
학습 목적: 이 모듈은 lambda 모듈의
invoke_arn을 입력으로 받아 그대로 라우트에 연결하는 "접착제" 역할이라,
동작도 단순하다: route_key로 지정한 라우트가 정확히 그 lambda_invoke_arn을
가리켜야 한다.

참고 문서:
- Amazon API Gateway v2 API: CreateApi, CreateRoute, CreateStage
  — modules/api-gateway/README.md의 공식문서 절 참고
*)
EXTENDS Naturals, Sequences, TLC

CONSTANTS
    Name,               \* STRING
    LambdaInvokeArn,    \* STRING — lambda 모듈의 invoke_arn 출력
    LambdaFunctionName, \* STRING
    RouteKey            \* STRING, 기본 "$default"

Input == [
    name                    |-> Name,
    lambda_invoke_arn       |-> LambdaInvokeArn,
    lambda_function_name    |-> LambdaFunctionName,
    route_key               |-> RouteKey
]

Precondition(input) ==
    /\ input.name \in STRING /\ input.name # ""
    /\ input.lambda_invoke_arn \in STRING /\ input.lambda_invoke_arn # ""
    /\ input.lambda_function_name \in STRING
    /\ input.route_key \in STRING

\* 1. CreateApi(name, protocol=HTTP)
\* 2. CreateIntegration(api, lambda_invoke_arn) -> integration_id
\* 3. CreateRoute(api, route_key, target=integration_id)
\* 4. CreateStage(api, "$default", auto_deploy=true) -> invoke_url
\* 5. AddPermission(lambda_function_name, principal=apigateway)
Provision(input) ==
    [
        api_id         |-> "api-" \o input.name,
        api_endpoint   |-> "https://api-" \o input.name \o ".execute-api.region.amazonaws.com",
        route_target   |-> input.lambda_invoke_arn  \* 이 라우트가 실제로 가리키는 통합 대상
    ]

\* 이게 이 스펙의 핵심: 라우트가 실제로 연결된 대상은 정확히 우리가
\* 넘긴 lambda_invoke_arn이어야 한다 — 다른 함수의 invoke_arn이 실수로
\* 연결되면 API가 완전히 엉뚱한 함수를 호출하게 된다.
Postcondition(input, output) ==
    /\ output.route_target = input.lambda_invoke_arn
    /\ output.api_endpoint \in STRING /\ output.api_endpoint # ""

VARIABLES dummy
vars == <<dummy>>
Init == dummy = TRUE
Next == UNCHANGED dummy
Spec == Init /\ [][Next]_vars

BehaviorHolds == Precondition(Input) => Postcondition(Input, Provision(Input))

====
