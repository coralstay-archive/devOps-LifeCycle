# redshift

Single-node cluster (cheapest option — bump `node_type`/`cluster_type` to multi-node when data volume needs it), encrypted, master password managed natively via Secrets Manager (`manage_master_password`, same pattern as `rds-postgres`).

## Status

Implemented (minimal).

## 런타임 불변식 (precondition/postcondition)

`aws_redshift_cluster.this`에 `precondition`을 달아, `database_name`이 소문자로 시작하는 소문자/숫자/언더스코어 조합인지 검증한다 — Redshift 네이밍 규칙.

## 공식문서

- [Amazon Redshift 관리 안내서](https://docs.aws.amazon.com/redshift/latest/mgmt/welcome.html)
- Terraform: [`aws_redshift_cluster`](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/redshift_cluster)

<!-- BEGIN_TF_DOCS -->
## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_allowed_security_group_ids"></a> [allowed\_security\_group\_ids](#input\_allowed\_security\_group\_ids) | n/a | `list(string)` | `[]` | no |
| <a name="input_cluster_identifier"></a> [cluster\_identifier](#input\_cluster\_identifier) | n/a | `string` | n/a | yes |
| <a name="input_database_name"></a> [database\_name](#input\_database\_name) | n/a | `string` | `"app"` | no |
| <a name="input_master_username"></a> [master\_username](#input\_master\_username) | n/a | `string` | `"admin"` | no |
| <a name="input_node_type"></a> [node\_type](#input\_node\_type) | n/a | `string` | `"dc2.large"` | no |
| <a name="input_private_subnet_ids"></a> [private\_subnet\_ids](#input\_private\_subnet\_ids) | n/a | `list(string)` | n/a | yes |
| <a name="input_skip_final_snapshot"></a> [skip\_final\_snapshot](#input\_skip\_final\_snapshot) | n/a | `bool` | `false` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | `{}` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_cluster_id"></a> [cluster\_id](#output\_cluster\_id) | n/a |
| <a name="output_endpoint"></a> [endpoint](#output\_endpoint) | n/a |
<!-- END_TF_DOCS -->
