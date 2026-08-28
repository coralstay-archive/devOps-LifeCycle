# lambda

One function from a local zip (`filename`), basic-execution IAM role, explicit log group with retention (so logs don't accumulate forever, unlike Lambda's auto-created group default of "never expire").

## Status

Implemented (minimal). No VPC attachment, no layers, no provisioned concurrency — add when a scenario needs them.

## Not yet included

Checkov/Trivy findings that are real, accepted trade-offs:
- **Not attached to a VPC** — intentional: most Lambda use cases here (serverless-api, event-driven-microservices) don't need to reach anything VPC-private, and VPC attachment adds cold-start latency + needs its own subnets/NAT. Add `vpc_config` when a scenario's function needs to reach an RDS/ElastiCache instance directly.
- **No Dead Letter Queue** — needs an `sns-sqs` (or plain SQS) queue wired to `dead_letter_config`; add when a scenario needs to inspect failed async invocations instead of just retrying/dropping them.
- **No reserved concurrency limit** — unbounded by default, which is the right default for most cases (don't want one function's traffic starving others via account-level concurrency); set `reserved_concurrent_executions` when a scenario specifically needs a ceiling (see `specs/serverless-api/spec.tla`'s `MaxConcurrency` for why this matters).
- **No code-signing validation** — needs an AWS Signer profile; add for scenarios with a supply-chain-integrity requirement.
- **CloudWatch Log Group not encrypted with KMS** — uses CloudWatch's default encryption. Add a `kms_key_arn` variable if a scenario needs key rotation control/audit.
- **Log retention is a variable, not fixed at "1 year+"** (`log_retention_days` defaults to 14) — deliberately configurable per caller rather than a fixed compliance-driven minimum.
- **Environment variables not KMS-encrypted with a customer key** — Lambda always encrypts environment variables at rest with an AWS-managed key; this finding wants a customer-managed one specifically.

## 런타임 불변식 (precondition/postcondition)

`aws_lambda_function.this`에 `precondition`을 달아, `memory_size`가 128~10240MB 범위인지 검증한다 — 실제 Lambda API 요구사항.

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
