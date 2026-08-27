# kms

Customer-managed KMS key with automatic annual rotation, plus an alias. Uses AWS's default key policy (full access for the account root), which is fine for most cases — narrow it with a custom `policy` if a specific service/role needs scoped access.

## Status

Implemented (minimal).

## 런타임 불변식 (precondition/postcondition)

`aws_kms_key.this`에 `precondition`을 달아, `deletion_window_in_days`가 7~30 범위인지 검증한다 — 실제 KMS API 요구사항.

## 공식문서

- [AWS KMS 개발자 안내서](https://docs.aws.amazon.com/kms/latest/developerguide/overview.html)
- Terraform: [`aws_kms_key`](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key)

<!-- BEGIN_TF_DOCS -->
## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_deletion_window_in_days"></a> [deletion\_window\_in\_days](#input\_deletion\_window\_in\_days) | n/a | `number` | `30` | no |
| <a name="input_name"></a> [name](#input\_name) | Alias name (without the alias/ prefix) | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_alias_name"></a> [alias\_name](#output\_alias\_name) | n/a |
| <a name="output_key_arn"></a> [key\_arn](#output\_key\_arn) | n/a |
| <a name="output_key_id"></a> [key\_id](#output\_key\_id) | n/a |
<!-- END_TF_DOCS -->
