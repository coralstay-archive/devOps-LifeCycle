# api-gateway

HTTP API (v2, cheaper/simpler than REST API v1) with a single Lambda proxy integration and auto-deployed `$default` stage. Feed it the `lambda` module's `invoke_arn` and `function_name` outputs.

## Status

Implemented (minimal). One route only — add more `aws_apigatewayv2_route`/`aws_apigatewayv2_integration` pairs for multiple endpoints, or use `$default` (current default) to proxy everything to one Lambda that does its own routing.

## 공식문서

- [API Gateway: HTTP API](https://docs.aws.amazon.com/apigateway/latest/developerguide/http-api.html)
- Terraform: [`aws_apigatewayv2_api`](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apigatewayv2_api)

<!-- BEGIN_TF_DOCS -->
## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_lambda_function_name"></a> [lambda\_function\_name](#input\_lambda\_function\_name) | n/a | `string` | n/a | yes |
| <a name="input_lambda_invoke_arn"></a> [lambda\_invoke\_arn](#input\_lambda\_invoke\_arn) | invoke\_arn output from the lambda module | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | n/a | yes |
| <a name="input_route_key"></a> [route\_key](#input\_route\_key) | e.g. "GET /items" or "$default" | `string` | `"$default"` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_api_endpoint"></a> [api\_endpoint](#output\_api\_endpoint) | n/a |
| <a name="output_api_id"></a> [api\_id](#output\_api\_id) | n/a |
<!-- END_TF_DOCS -->
