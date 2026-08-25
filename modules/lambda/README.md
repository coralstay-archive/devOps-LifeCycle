# lambda

One function from a local zip (`filename`), basic-execution IAM role, explicit log group with retention (so logs don't accumulate forever, unlike Lambda's auto-created group default of "never expire").

## Status

Implemented (minimal). No VPC attachment, no layers, no provisioned concurrency — add when a scenario needs them.

## 공식문서

- [AWS Lambda 개발자 안내서](https://docs.aws.amazon.com/lambda/latest/dg/welcome.html)
- Terraform: [`aws_lambda_function`](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function)

<!-- BEGIN_TF_DOCS -->
## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_environment_variables"></a> [environment\_variables](#input\_environment\_variables) | n/a | `map(string)` | `{}` | no |
| <a name="input_filename"></a> [filename](#input\_filename) | Path to the deployment package zip | `string` | n/a | yes |
| <a name="input_function_name"></a> [function\_name](#input\_function\_name) | n/a | `string` | n/a | yes |
| <a name="input_handler"></a> [handler](#input\_handler) | n/a | `string` | `"index.handler"` | no |
| <a name="input_log_retention_days"></a> [log\_retention\_days](#input\_log\_retention\_days) | n/a | `number` | `14` | no |
| <a name="input_memory_size"></a> [memory\_size](#input\_memory\_size) | n/a | `number` | `128` | no |
| <a name="input_runtime"></a> [runtime](#input\_runtime) | n/a | `string` | `"python3.13"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | `{}` | no |
| <a name="input_timeout"></a> [timeout](#input\_timeout) | n/a | `number` | `10` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_function_arn"></a> [function\_arn](#output\_function\_arn) | n/a |
| <a name="output_function_name"></a> [function\_name](#output\_function\_name) | n/a |
| <a name="output_invoke_arn"></a> [invoke\_arn](#output\_invoke\_arn) | n/a |
| <a name="output_role_arn"></a> [role\_arn](#output\_role\_arn) | n/a |
| <a name="output_role_name"></a> [role\_name](#output\_role\_name) | n/a |
<!-- END_TF_DOCS -->
