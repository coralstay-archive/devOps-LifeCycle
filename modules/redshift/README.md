# redshift

Single-node cluster (cheapest option — bump `node_type`/`cluster_type` to multi-node when data volume needs it), encrypted, master password managed natively via Secrets Manager (`manage_master_password`, same pattern as `rds-postgres`).

## Status

Implemented (minimal).

## Not yet included

Checkov/Trivy findings that are real, accepted trade-offs:
- **`master_username` defaults to `"admin"`** — a commonly-guessed username, flagged alongside public-access checks. The username alone isn't the security boundary here (the security group + `publicly_accessible = false` are); changing the default doesn't meaningfully harden anything, so it's left as the conventional default rather than picked to satisfy a scanner.
- **Egress not scoped down (0.0.0.0/0)** — see the security group resource's inline comment.

Fixed — now configurable rather than hardcoded:
- **Customer-managed KMS key** — `kms_key_arn` variable (default `null`, falls back to the AWS-managed `aws/redshift` key).
- **Enhanced VPC routing** — `enhanced_vpc_routing` variable, defaulting to `true` (free; forces COPY/UNLOAD traffic through the VPC instead of the public internet — requires the VPC to actually have a route to S3, e.g. via `vpc-endpoints`, or those commands will fail).
- **Audit logging** — `logging_bucket_name`/`logging_s3_key_prefix` variables, both `null` by default (disabled). The target bucket must already exist with the Redshift log-delivery bucket policy attached — this module doesn't create that bucket for you.

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
| <a name="input_enhanced_vpc_routing"></a> [enhanced\_vpc\_routing](#input\_enhanced\_vpc\_routing) | Route COPY/UNLOAD traffic through the VPC instead of the public internet (free; requires the VPC to have a route to S3, e.g. via vpc-endpoints) | `bool` | `true` | no |
| <a name="input_kms_key_arn"></a> [kms\_key\_arn](#input\_kms\_key\_arn) | Customer-managed KMS key for cluster encryption. Leave null to use the AWS-managed aws/redshift key (current default). | `string` | `null` | no |
| <a name="input_logging_bucket_name"></a> [logging\_bucket\_name](#input\_logging\_bucket\_name) | S3 bucket to receive Redshift audit logs (must already exist with the Redshift log-delivery bucket policy attached). Leave null to disable audit logging. | `string` | `null` | no |
| <a name="input_logging_s3_key_prefix"></a> [logging\_s3\_key\_prefix](#input\_logging\_s3\_key\_prefix) | S3 key prefix for audit logs, used only when logging\_bucket\_name is set | `string` | `null` | no |
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
| <a name="output_master_password_secret_arn"></a> [master\_password\_secret\_arn](#output\_master\_password\_secret\_arn) | ARN of the Secrets Manager secret holding the master password |
<!-- END_TF_DOCS -->
