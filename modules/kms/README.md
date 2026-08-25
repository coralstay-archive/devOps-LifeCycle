# kms

Customer-managed KMS key with automatic annual rotation, plus an alias. Uses AWS's default key policy (full access for the account root), which is fine for most cases — narrow it with a custom `policy` if a specific service/role needs scoped access.

## Status

Implemented (minimal).

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
