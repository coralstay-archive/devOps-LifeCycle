# dynamodb

Single-table, on-demand billing (no capacity planning needed), point-in-time recovery + encryption on by default.

## Status

Implemented (minimal). No range key, no GSIs/LSIs — add when a scenario's access patterns need them.

## Not yet included

**Customer-managed KMS key** — encrypted with the AWS-owned default key (encryption at rest is always on; this is about who manages the key). Add a `kms_key_arn` variable (`server_side_encryption { kms_key_arn = ... }`) if a scenario needs key rotation control/audit.

## 런타임 불변식 (precondition/postcondition)

`aws_dynamodb_table.this`에 `precondition`을 달아, `hash_key_type`이 S/N/B 중 하나인지 검증한다 — DynamoDB의 유일한 유효 속성 타입.

## 공식문서

- [Amazon DynamoDB 개발자 안내서](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Introduction.html)
- Terraform: [`aws_dynamodb_table`](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table)

<!-- BEGIN_TF_DOCS -->
## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_hash_key"></a> [hash\_key](#input\_hash\_key) | n/a | `string` | `"id"` | no |
| <a name="input_hash_key_type"></a> [hash\_key\_type](#input\_hash\_key\_type) | S, N, or B | `string` | `"S"` | no |
| <a name="input_table_name"></a> [table\_name](#input\_table\_name) | n/a | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_table_arn"></a> [table\_arn](#output\_table\_arn) | n/a |
| <a name="output_table_name"></a> [table\_name](#output\_table\_name) | n/a |
<!-- END_TF_DOCS -->
