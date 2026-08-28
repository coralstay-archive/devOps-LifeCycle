# step-functions

State machine + IAM role. Ships with a placeholder single-Pass-state definition so it plans/applies out of the box; pass a real Amazon States Language `definition` and the `policy_arns` it needs (e.g. Lambda invoke) for actual orchestration (`etl-batch`, `ml-training-pipeline`).

## Status

Implemented (minimal). Execution logging (`logging_configuration`, ERROR level) and X-Ray tracing are on by default — see the log group and IAM policy in `main.tf` for what that actually requires (Step Functions' CloudWatch Logs integration needs a specific set of `logs:*LogDelivery*` actions, not just `logs:PutLogEvents`).

## Not yet included

Checkov/Trivy findings on the log group added above, now both configurable via opt-in variables (defaults preserve prior behavior exactly):
- **Retention is 14 days, not 1+ year** — `log_retention_days` (default `14`, matching `lambda`'s convention) rather than a fixed compliance-driven minimum. Checkov wants >= 365; raise the variable per caller if that's a real requirement.
- **Log group not encrypted with a customer-managed KMS key** — `log_kms_key_arn` (default `null` = CloudWatch's default encryption).

## 런타임 불변식 (precondition/postcondition)

`aws_sfn_state_machine.this`에 `precondition`을 달아, `definition`이 유효한 JSON인지 검증한다 — ASL은 HCL이 아니라 JSON이다.

## 공식문서

- [AWS Step Functions 개발자 안내서](https://docs.aws.amazon.com/step-functions/latest/dg/welcome.html)
- Terraform: [`aws_sfn_state_machine`](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sfn_state_machine)

<!-- BEGIN_TF_DOCS -->
## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_definition"></a> [definition](#input\_definition) | Amazon States Language JSON. Defaults to a trivial single-Pass-state machine so this module works with zero required config beyond `name`. | `string` | `"{\n  \"Comment\": \"Placeholder state machine - replace with a real definition\",\n  \"StartAt\": \"Placeholder\",\n  \"States\": {\n    \"Placeholder\": {\n      \"Type\": \"Pass\",\n      \"End\": true\n    }\n  }\n}\n"` | no |
| <a name="input_log_kms_key_arn"></a> [log\_kms\_key\_arn](#input\_log\_kms\_key\_arn) | Customer-managed KMS key for the execution log group. Defaults to null, which uses CloudWatch Logs' default encryption. | `string` | `null` | no |
| <a name="input_log_retention_days"></a> [log\_retention\_days](#input\_log\_retention\_days) | State machine execution log group retention. Checkov wants >= 365 for compliance; defaults to 14 here to match this repo's cost-conscious convention (see lambda's log\_retention\_days) — raise it per caller when needed. | `number` | `14` | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | n/a | yes |
| <a name="input_policy_arns"></a> [policy\_arns](#input\_policy\_arns) | Managed policy ARNs to attach (e.g. to let it invoke Lambda/Glue) | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_role_arn"></a> [role\_arn](#output\_role\_arn) | n/a |
| <a name="output_state_machine_arn"></a> [state\_machine\_arn](#output\_state\_machine\_arn) | n/a |
<!-- END_TF_DOCS -->
