# dynamodb

Single-table, on-demand billing (no capacity planning needed), point-in-time recovery + encryption on by default.

## Status

Implemented (minimal). No range key, no GSIs/LSIs — add when a scenario's access patterns need them.

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
