# dms

Full-load-and-CDC replication task, source assumed to be a relational DB (default: Postgres — point it at `rds-postgres`'s endpoint), target defaults to Kafka (pair with `msk-kafka`'s `bootstrap_brokers_tls` output) for `cdc-pipeline`. Swap `target_engine_name` (e.g. to `s3`) for other CDC targets — the `kafka_settings` block would need to change accordingly if so.

## Status

Implemented (minimal): one source, one target, one task, capturing all tables by default.

## Security note

`source_password` is a plain sensitive variable here for simplicity. In practice, read it from the `secrets-manager` module instead of passing it as a bare tfvar.

## Not yet included

**Customer-managed KMS key** — both the replication instance and endpoints are encrypted with the AWS-managed `aws/dms` key by default. Pass `kms_key_arn` if a scenario needs key rotation control/audit — falls back to the AWS-managed key when left `null`.

**Egress not scoped down (0.0.0.0/0)** — see the security group resource's inline comment for why (the replication instance only ever makes outbound connections, to arbitrary source/target endpoints).

## 런타임 불변식 (precondition/postcondition)

`aws_dms_endpoint.source`에 `precondition`을 달아, `source_port`가 유효한 TCP 포트 범위(1-65535)인지 검증한다. `aws_dms_endpoint.target`에도 `precondition`을 달아, `target_engine_name`이 "kafka"면 `target_kafka_broker`가 반드시 설정되어 있는지 검증한다(`specs/modules/dms/spec.tla`로 이 모듈의 입출력 동작을 정리하다가, 이 조합을 막는 검증이 빠져 있던 걸 발견해 추가했다).

## 공식문서

- [AWS DMS 사용 설명서](https://docs.aws.amazon.com/dms/latest/userguide/)
- [AWS DMS 모범 사례](https://docs.aws.amazon.com/dms/latest/userguide/CHAP_BestPractices.html)
- Terraform: [`aws_dms_replication_instance`](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dms_replication_instance), [`aws_dms_replication_task`](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dms_replication_task)

<!-- BEGIN_TF_DOCS -->
## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_kms_key_arn"></a> [kms\_key\_arn](#input\_kms\_key\_arn) | Customer-managed KMS key for the replication instance and both endpoints. Defaults to null, which falls back to the AWS-managed aws/dms key. | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | Name used as the base for the replication instance, task, and endpoint identifiers. | `string` | n/a | yes |
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
