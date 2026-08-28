# step-functions

State machine + IAM role. Ships with a placeholder single-Pass-state definition so it plans/applies out of the box; pass a real Amazon States Language `definition` and the `policy_arns` it needs (e.g. Lambda invoke) for actual orchestration (`etl-batch`, `ml-training-pipeline`).

## Status

Implemented (minimal). Execution logging (`logging_configuration`, ERROR level) and X-Ray tracing are on by default — see the log group and IAM policy in `main.tf` for what that actually requires (Step Functions' CloudWatch Logs integration needs a specific set of `logs:*LogDelivery*` actions, not just `logs:PutLogEvents`).

## Not yet included

Checkov/Trivy findings on the log group added above:
- **Retention is 14 days, not 1+ year** — matches this repo's convention elsewhere (`lambda`'s `log_retention_days` also defaults to 14) rather than a longer compliance-driven minimum; make it a variable if a scenario needs longer retention.
- **Log group not encrypted with a customer-managed KMS key** — uses CloudWatch's default encryption. Add a `kms_key_arn` variable if a scenario needs key rotation control/audit.

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
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | n/a | yes |
| <a name="input_policy_arns"></a> [policy\_arns](#input\_policy\_arns) | Managed policy ARNs to attach (e.g. to let it invoke Lambda/Glue) | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_role_arn"></a> [role\_arn](#output\_role\_arn) | n/a |
| <a name="output_state_machine_arn"></a> [state\_machine\_arn](#output\_state\_machine\_arn) | n/a |
<!-- END_TF_DOCS -->
