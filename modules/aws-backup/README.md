# aws-backup

Vault + daily plan (05:00 UTC default, 35-day retention default) + a selection covering whatever ARNs you pass in `resource_arns` (e.g. an RDS instance ARN).

## Status

Implemented (minimal): one schedule/rule. Add tag-based selection (`selection_tag`) instead of explicit ARNs if you'd rather back up "everything tagged X".

## Not yet included

**Customer-managed KMS key for the vault** — encrypted with the AWS-managed `aws/backup` key by default. Pass `kms_key_arn` if a scenario needs key rotation control/audit — falls back to the AWS-managed key when left `null`.

## 런타임 불변식 (precondition/postcondition)

`aws_backup_plan.this`에 `precondition`을 달아, `retention_days`가 1 이상인지 검증한다. (참고: AWS Backup 규칙 자체의 `lifecycle { delete_after = ... }`와 Terraform 메타인수 `lifecycle` 블록이 이름이 같지만 완전히 다른 개념이니 헷갈리지 말 것 — 전자는 리소스 인수, 후자는 이 리소스를 감싸는 Terraform 문법이다.)

## 공식문서

- [AWS Backup 개발자 안내서](https://docs.aws.amazon.com/aws-backup/latest/devguide/whatisbackup.html)
- Terraform: [`aws_backup_plan`](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/backup_plan)

<!-- BEGIN_TF_DOCS -->
## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_kms_key_arn"></a> [kms\_key\_arn](#input\_kms\_key\_arn) | Customer-managed KMS key for the backup vault. Defaults to null, which falls back to the AWS-managed aws/backup key. | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | n/a | yes |
| <a name="input_resource_arns"></a> [resource\_arns](#input\_resource\_arns) | ARNs to back up | `list(string)` | `[]` | no |
| <a name="input_retention_days"></a> [retention\_days](#input\_retention\_days) | n/a | `number` | `35` | no |
| <a name="input_schedule"></a> [schedule](#input\_schedule) | Cron expression, default daily at 05:00 UTC | `string` | `"cron(0 5 * * ? *)"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_plan_id"></a> [plan\_id](#output\_plan\_id) | n/a |
| <a name="output_vault_name"></a> [vault\_name](#output\_vault\_name) | n/a |
<!-- END_TF_DOCS -->
