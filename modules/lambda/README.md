# lambda

One function from a local zip (`filename`), basic-execution IAM role, explicit log group with retention (so logs don't accumulate forever, unlike Lambda's auto-created group default of "never expire").

## Status

Implemented (minimal). No layers, no provisioned concurrency — add when a scenario needs them.

## Not yet included

Checkov/Trivy findings that are real, accepted trade-offs:
- **Log retention is a variable, not fixed at "1 year+"** (`log_retention_days` defaults to 14) — deliberately configurable per caller rather than a fixed compliance-driven minimum.

Now configurable via opt-in variables (all default to off/unset, matching prior behavior exactly):
- **Dead Letter Queue** — set `dead_letter_target_arn` (an `sns-sqs` or plain SQS queue ARN) to capture failed async invocations instead of just retrying/dropping them.
- **Reserved concurrency limit** — `reserved_concurrent_executions` (default `null` = unbounded, the right default for most cases so one function's traffic doesn't starve others via account-level concurrency; see `specs/serverless-api/spec.tla`'s `MaxConcurrency` for why this matters when it *is* set).
- **CloudWatch Log Group KMS encryption** — `log_kms_key_arn` (default `null` = CloudWatch's default encryption).
- **Environment variable KMS encryption** — `kms_key_arn` (default `null` = Lambda's AWS-managed key; set to a CMK for key rotation control/audit).
- **VPC attachment** — set `subnet_ids` (and optionally `security_group_ids`) to reach something VPC-private (RDS, ElastiCache) directly. Empty `subnet_ids` (default) keeps the function on the Lambda service network — attaching to a VPC is a real cold-start latency trade-off (mitigated but not eliminated by AWS's Hyperplane ENI model), not just a toggle, so only set this when the function genuinely needs private network access. The module handles the extra IAM policy (`AWSLambdaVPCAccessExecutionRole`) automatically when subnets are set.
- **Code-signing** — set `code_signing_config_arn` to an existing AWS Signer profile-backed config to enforce signature validation on deployment. This module doesn't create the Signer profile itself (that requires a real code-signing certificate/CA setup done out-of-band); add for scenarios with a supply-chain-integrity requirement.

## 런타임 불변식 (precondition/postcondition)

`aws_lambda_function.this`에 `precondition`을 달아, `memory_size`가 128~10240MB 범위인지 검증한다 — 실제 Lambda API 요구사항.

## 공식문서

- [AWS Lambda 개발자 안내서](https://docs.aws.amazon.com/lambda/latest/dg/welcome.html)
- Terraform: [`aws_lambda_function`](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function)

<!-- BEGIN_TF_DOCS -->
## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_code_signing_config_arn"></a> [code\_signing\_config\_arn](#input\_code\_signing\_config\_arn) | ARN of an aws\_signer\_signing\_profile-backed code signing config. Requires an AWS Signer profile set up out-of-band (this module doesn't create one) -- leave null to skip code-signing enforcement entirely. | `string` | `null` | no |
| <a name="input_dead_letter_target_arn"></a> [dead\_letter\_target\_arn](#input\_dead\_letter\_target\_arn) | SNS topic or SQS queue ARN to send failed async invocations to. Leave null to just retry/drop them. | `string` | `null` | no |
| <a name="input_environment_variables"></a> [environment\_variables](#input\_environment\_variables) | Environment variables passed to the function. | `map(string)` | `{}` | no |
| <a name="input_filename"></a> [filename](#input\_filename) | Path to the deployment package zip | `string` | n/a | yes |
| <a name="input_function_name"></a> [function\_name](#input\_function\_name) | Name of the Lambda function | `string` | n/a | yes |
| <a name="input_handler"></a> [handler](#input\_handler) | Function entrypoint, as <file>.<exported function> for the given runtime. | `string` | `"index.handler"` | no |
| <a name="input_kms_key_arn"></a> [kms\_key\_arn](#input\_kms\_key\_arn) | Customer-managed KMS key to encrypt environment variables with. Defaults to null, which uses Lambda's AWS-managed key. | `string` | `null` | no |
| <a name="input_log_kms_key_arn"></a> [log\_kms\_key\_arn](#input\_log\_kms\_key\_arn) | Customer-managed KMS key for the function's log group. Defaults to null, which uses CloudWatch Logs' default encryption. | `string` | `null` | no |
| <a name="input_log_retention_days"></a> [log\_retention\_days](#input\_log\_retention\_days) | CloudWatch retention for the function's log group -- declared explicitly since Lambda's auto-created log group defaults to never expiring, which quietly accumulates cost forever. | `number` | `14` | no |
| <a name="input_memory_size"></a> [memory\_size](#input\_memory\_size) | Memory allocated to the function in MB (128-10240, a real Lambda API range enforced by this module's precondition) -- also proportionally scales the CPU/network available to the function. | `number` | `128` | no |
| <a name="input_reserved_concurrent_executions"></a> [reserved\_concurrent\_executions](#input\_reserved\_concurrent\_executions) | Ceiling on concurrent executions for this function. Leave null for unreserved (Lambda's default — bounded only by the account-level limit). | `number` | `null` | no |
| <a name="input_runtime"></a> [runtime](#input\_runtime) | Lambda runtime identifier (e.g. python3.13, nodejs20.x). | `string` | `"python3.13"` | no |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | Security group IDs for the function's ENIs. Only used when subnet\_ids is non-empty. | `list(string)` | `[]` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | Private subnet IDs to attach the function to (e.g. to reach rds-postgres/elasticache-redis). Empty list (default) keeps the function off any VPC, on the Lambda service network -- attaching to a VPC is a real cold-start latency trade-off, not just a toggle, so only set this when the function actually needs to reach something private. | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags applied to the function, its IAM role, and its log group | `map(string)` | `{}` | no |
| <a name="input_timeout"></a> [timeout](#input\_timeout) | Maximum execution duration in seconds before Lambda terminates the invocation. | `number` | `10` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_function_arn"></a> [function\_arn](#output\_function\_arn) | ARN of the created Lambda function |
| <a name="output_function_name"></a> [function\_name](#output\_function\_name) | Name of the created Lambda function |
| <a name="output_invoke_arn"></a> [invoke\_arn](#output\_invoke\_arn) | Invocation ARN for wiring into an API Gateway integration (aws\_apigatewayv2\_integration.integration\_uri) |
| <a name="output_role_arn"></a> [role\_arn](#output\_role\_arn) | ARN of the function's execution IAM role |
| <a name="output_role_name"></a> [role\_name](#output\_role\_name) | Name of the function's execution IAM role |
<!-- END_TF_DOCS -->
