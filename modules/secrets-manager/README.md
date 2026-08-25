# secrets-manager

A single secret. For RDS master passwords, prefer `rds-postgres`'s built-in `manage_master_user_password` instead of wiring a secret here manually — this module is for everything else (third-party API keys, etc.).

## Status

Implemented (minimal). No rotation configured — add `aws_secretsmanager_secret_rotation` when a secret needs it.

<!-- BEGIN_TF_DOCS -->
## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | n/a | yes |
| <a name="input_secret_string"></a> [secret\_string](#input\_secret\_string) | Initial secret value. Leave null to create an empty secret and fill it in outside Terraform (recommended for anything rotated). | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_secret_arn"></a> [secret\_arn](#output\_secret\_arn) | n/a |
| <a name="output_secret_id"></a> [secret\_id](#output\_secret\_id) | n/a |
<!-- END_TF_DOCS -->
