# dms

Full-load-and-CDC replication task, source assumed to be a relational DB (default: Postgres — point it at `rds-postgres`'s endpoint), target defaults to Kafka (pair with `msk-kafka`'s `bootstrap_brokers_tls` output) for `cdc-pipeline`. Swap `target_engine_name` (e.g. to `s3`) for other CDC targets — the `kafka_settings` block would need to change accordingly if so.

## Status

Implemented (minimal): one source, one target, one task, capturing all tables by default.

## Security note

`source_password` is a plain sensitive variable here for simplicity. In practice, read it from the `secrets-manager` module instead of passing it as a bare tfvar.

## 공식문서

- [AWS DMS 사용 설명서](https://docs.aws.amazon.com/dms/latest/userguide/)
- [AWS DMS 모범 사례](https://docs.aws.amazon.com/dms/latest/userguide/CHAP_BestPractices.html)
- Terraform: [`aws_dms_replication_instance`](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dms_replication_instance), [`aws_dms_replication_task`](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dms_replication_task)

<!-- BEGIN_TF_DOCS -->
## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | n/a | yes |
| <a name="input_private_subnet_ids"></a> [private\_subnet\_ids](#input\_private\_subnet\_ids) | n/a | `list(string)` | n/a | yes |
| <a name="input_replication_instance_class"></a> [replication\_instance\_class](#input\_replication\_instance\_class) | n/a | `string` | `"dms.t3.micro"` | no |
| <a name="input_source_database_name"></a> [source\_database\_name](#input\_source\_database\_name) | n/a | `string` | n/a | yes |
| <a name="input_source_engine_name"></a> [source\_engine\_name](#input\_source\_engine\_name) | e.g. postgres, mysql | `string` | `"postgres"` | no |
| <a name="input_source_password"></a> [source\_password](#input\_source\_password) | n/a | `string` | n/a | yes |
| <a name="input_source_port"></a> [source\_port](#input\_source\_port) | n/a | `number` | `5432` | no |
| <a name="input_source_server_name"></a> [source\_server\_name](#input\_source\_server\_name) | n/a | `string` | n/a | yes |
| <a name="input_source_username"></a> [source\_username](#input\_source\_username) | n/a | `string` | n/a | yes |
| <a name="input_table_mappings"></a> [table\_mappings](#input\_table\_mappings) | DMS table mapping JSON. Defaults to capturing every table in every schema. | `string` | `"{\n  \"rules\": [{\n    \"rule-type\": \"selection\",\n    \"rule-id\": \"1\",\n    \"rule-name\": \"1\",\n    \"object-locator\": { \"schema-name\": \"%\", \"table-name\": \"%\" },\n    \"rule-action\": \"include\"\n  }]\n}\n"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | `{}` | no |
| <a name="input_target_engine_name"></a> [target\_engine\_name](#input\_target\_engine\_name) | n/a | `string` | `"kafka"` | no |
| <a name="input_target_kafka_broker"></a> [target\_kafka\_broker](#input\_target\_kafka\_broker) | Used when target\_engine\_name = kafka: broker1:port,broker2:port | `string` | `null` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_replication_instance_arn"></a> [replication\_instance\_arn](#output\_replication\_instance\_arn) | n/a |
| <a name="output_replication_task_arn"></a> [replication\_task\_arn](#output\_replication\_task\_arn) | n/a |
<!-- END_TF_DOCS -->
