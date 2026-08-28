# api-gateway

HTTP API (v2, cheaper/simpler than REST API v1) with a single Lambda proxy integration and auto-deployed `$default` stage. Feed it the `lambda` module's `invoke_arn` and `function_name` outputs.

## Status

Implemented (minimal). One route only — add more `aws_apigatewayv2_route`/`aws_apigatewayv2_integration` pairs for multiple endpoints, or use `$default` (current default) to proxy everything to one Lambda that does its own routing.

## Not yet included

**Access logging is now on unconditionally** — a `aws_cloudwatch_log_group` (`log_retention_days`, default 14) plus `access_log_settings` on the `$default` stage, logging request ID/IP/method/route/status/latency-relevant fields as JSON. This was a total gap before (no log group existed at all), not just a defaulted-off feature, and the CloudWatch cost here is minor.

Checkov/Trivy findings that are real, accepted trade-offs:
- **No route-level authorization** (`authorization_type`) — this module's `$default` route accepts unauthenticated requests by design (the Lambda behind it does its own auth if needed). Add a `authorizer_id`/Cognito or IAM authorizer when a scenario needs gateway-level auth.

## 런타임 불변식 (precondition/postcondition)

`aws_apigatewayv2_route.this`에 `precondition`을 달아, `route_key`가 `$default`이거나 올바른 `<METHOD> /path` 형식인지 검증한다.

## 공식문서

- [API Gateway: HTTP API](https://docs.aws.amazon.com/apigateway/latest/developerguide/http-api.html)
- Terraform: [`aws_apigatewayv2_api`](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apigatewayv2_api)

<!-- BEGIN_TF_DOCS -->
## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_lambda_function_name"></a> [lambda\_function\_name](#input\_lambda\_function\_name) | n/a | `string` | n/a | yes |
| <a name="input_lambda_invoke_arn"></a> [lambda\_invoke\_arn](#input\_lambda\_invoke\_arn) | invoke\_arn output from the lambda module | `string` | n/a | yes |
| <a name="input_log_retention_days"></a> [log\_retention\_days](#input\_log\_retention\_days) | CloudWatch retention for the stage's access log group. | `number` | `14` | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | n/a | yes |
| <a name="input_route_key"></a> [route\_key](#input\_route\_key) | e.g. "GET /items" or "$default" | `string` | `"$default"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags applied to the access-log group. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_api_endpoint"></a> [api\_endpoint](#output\_api\_endpoint) | n/a |
| <a name="output_api_id"></a> [api\_id](#output\_api\_id) | n/a |
<!-- END_TF_DOCS -->
