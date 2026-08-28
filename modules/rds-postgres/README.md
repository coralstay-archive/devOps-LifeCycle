# rds-postgres

Managed PostgreSQL, Multi-AZ by default, master password managed natively by RDS via Secrets Manager (`manage_master_user_password`) instead of a Terraform-managed password variable.

## Status

Implemented (minimal).

## Inputs / Outputs

See `variables.tf` / `outputs.tf`. Pass in security group IDs (e.g. from `ecs-service`/`eks`) via `allowed_security_group_ids` to open port 5432 to them.

## Not yet included

Read replicas, Aurora option, parameter group tuning, cross-region backup. Add when a scenario needs them.

**Enhanced monitoring is now available via `monitoring_interval`** (default `0`, disabled — RDS's own default) — set it to `1`/`5`/`10`/`15`/`30`/`60` seconds and the module creates its own IAM role (`monitoring.rds.amazonaws.com` + the `AmazonRDSEnhancedMonitoringRole` managed policy) automatically. Real per-instance CloudWatch cost when enabled, so it stays off by default.

Checkov/Trivy findings that are real, accepted trade-offs:
- **Customer-managed KMS key for Performance Insights** — `performance_insights_kms_key_id` defaults to `null` (AWS-managed key). Pass a `performance_insights_kms_key_id` if a scenario needs key rotation control/audit.

**Log exports to CloudWatch** are now on by default (`log_exports = ["postgresql", "upgrade"]`) — this does have a real CloudWatch ingestion cost, so pass `log_exports = []` to opt back out if that matters for a cost-sensitive scenario.

One finding that's a checkov false-positive, not a gap: **"deletion protection not enabled"** — it's actually on by default (`deletion_protection = !var.skip_final_snapshot`, and `skip_final_snapshot` defaults to `false`). Checkov's static check only accepts a literal `true`, not an expression, so it flags this even though the real behavior is already correct.

## 런타임 불변식 (precondition/postcondition)

`aws_db_instance.this`에 `precondition`을 달아, `allocated_storage`가 20GB 이상인지 검증한다 (PostgreSQL의 gp2/gp3 최소 스토리지).

## 공식문서

- [Amazon RDS for PostgreSQL 사용 설명서](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_PostgreSQL.html)
- Terraform: [`aws_db_instance`](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance)

<!-- BEGIN_TF_DOCS -->
## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_allocated_storage"></a> [allocated\_storage](#input\_allocated\_storage) | Allocated storage in GB | `number` | `20` | no |
| <a name="input_allowed_security_group_ids"></a> [allowed\_security\_group\_ids](#input\_allowed\_security\_group\_ids) | Security groups allowed to connect to Postgres on port 5432 | `list(string)` | `[]` | no |
| <a name="input_database_name"></a> [database\_name](#input\_database\_name) | Initial database name | `string` | `"app"` | no |
| <a name="input_engine_version"></a> [engine\_version](#input\_engine\_version) | PostgreSQL engine version | `string` | `"16.4"` | no |
| <a name="input_identifier"></a> [identifier](#input\_identifier) | RDS instance identifier | `string` | n/a | yes |
| <a name="input_instance_class"></a> [instance\_class](#input\_instance\_class) | RDS instance class | `string` | `"db.t4g.micro"` | no |
| <a name="input_log_exports"></a> [log\_exports](#input\_log\_exports) | PostgreSQL log types to export to CloudWatch Logs (has a real CloudWatch ingestion cost) | `list(string)` | <pre>[<br/>  "postgresql",<br/>  "upgrade"<br/>]</pre> | no |
| <a name="input_master_username"></a> [master\_username](#input\_master\_username) | Master username | `string` | `"app_admin"` | no |
| <a name="input_monitoring_interval"></a> [monitoring\_interval](#input\_monitoring\_interval) | Enhanced Monitoring granularity in seconds (0, 1, 5, 10, 15, 30, 60). 0 disables it (RDS's default) -- creates its own IAM role and has a real per-instance cost when > 0. | `number` | `0` | no |
| <a name="input_multi_az"></a> [multi\_az](#input\_multi\_az) | Enable Multi-AZ failover (spike/availability default: on) | `bool` | `true` | no |
| <a name="input_performance_insights_kms_key_id"></a> [performance\_insights\_kms\_key\_id](#input\_performance\_insights\_kms\_key\_id) | Customer-managed KMS key for Performance Insights encryption. Leave null to use the AWS-managed key. | `string` | `null` | no |
| <a name="input_private_subnet_ids"></a> [private\_subnet\_ids](#input\_private\_subnet\_ids) | Private subnet IDs for the DB subnet group (needs >= 2 AZs) | `list(string)` | n/a | yes |
| <a name="input_skip_final_snapshot"></a> [skip\_final\_snapshot](#input\_skip\_final\_snapshot) | Skip final snapshot on destroy (keep false for anything holding real data) | `bool` | `false` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags applied to all resources | `map(string)` | `{}` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC to place the instance in | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_arn"></a> [arn](#output\_arn) | n/a |
| <a name="output_db_instance_id"></a> [db\_instance\_id](#output\_db\_instance\_id) | n/a |
| <a name="output_endpoint"></a> [endpoint](#output\_endpoint) | Connection endpoint (host:port) |
| <a name="output_master_user_secret_arn"></a> [master\_user\_secret\_arn](#output\_master\_user\_secret\_arn) | ARN of the Secrets Manager secret holding the master password |
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | n/a |
<!-- END_TF_DOCS -->
