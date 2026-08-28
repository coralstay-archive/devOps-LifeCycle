# amazon-mq

Managed RabbitMQ (default) or ActiveMQ, single-instance deployment. **Only use this if something needs to speak AMQP/MQTT/STOMP/OpenWire specifically** — e.g. migrating an app that already talks to RabbitMQ/ActiveMQ. For anything built fresh on AWS, `sns-sqs` is the default choice, not this module.

## Status

Implemented (minimal): single-instance, no active/standby HA (use `deployment_mode = "ACTIVE_STANDBY_MULTI_AZ"` for that, not yet parameterized here).

## Not yet included

Checkov/Trivy findings that are real, accepted trade-offs:
- **Customer-managed KMS key** — broker is encrypted with the AWS-managed key by default. Pass `kms_key_arn` if a scenario needs key rotation control/audit — falls back to the AWS-owned key when left `null`.
- **Egress not scoped down (0.0.0.0/0)** — see the security group resource's inline comment.

General and audit logging to CloudWatch Logs are enabled unconditionally (`logs { general = true, audit = ... }`) — audit is ActiveMQ-only (RabbitMQ, the default engine, rejects it at broker-creation time), so it's gated on `var.engine_type == "ActiveMQ"` rather than always on.

## 런타임 불변식 (precondition/postcondition)

`aws_mq_broker.this`에 두 개의 `precondition`을 달았다: `engine_type`이 RabbitMQ 또는 ActiveMQ인지(Amazon MQ가 지원하는 유일한 엔진들), 그리고 `password`가 12~250자인지(Amazon MQ API 자체의 요구사항 — `specs/modules/amazon-mq/spec.tla`로 이 모듈의 입출력 동작을 정리하다가 이 검증이 빠져 있는 걸 발견해 추가했다).

## 공식문서

- [Amazon MQ 개발자 안내서](https://docs.aws.amazon.com/amazon-mq/latest/developerguide/welcome.html)
- Terraform: [`aws_mq_broker`](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/mq_broker)

<!-- BEGIN_TF_DOCS -->
## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_allowed_security_group_ids"></a> [allowed\_security\_group\_ids](#input\_allowed\_security\_group\_ids) | Security groups allowed to reach the broker on port 5671 (AMQP over TLS). | `list(string)` | `[]` | no |
| <a name="input_engine_type"></a> [engine\_type](#input\_engine\_type) | RabbitMQ or ActiveMQ — pick this only if you need protocol compatibility with an existing broker; otherwise use sns-sqs | `string` | `"RabbitMQ"` | no |
| <a name="input_engine_version"></a> [engine\_version](#input\_engine\_version) | Broker engine version -- must be a version RabbitMQ/ActiveMQ (whichever engine\_type picks) actually supports. | `string` | `"3.13"` | no |
| <a name="input_host_instance_type"></a> [host\_instance\_type](#input\_host\_instance\_type) | Broker instance type (e.g. mq.t3.micro) -- this module always deploys SINGLE\_INSTANCE, so there's no separate replica sizing. | `string` | `"mq.t3.micro"` | no |
| <a name="input_kms_key_arn"></a> [kms\_key\_arn](#input\_kms\_key\_arn) | Customer-managed KMS key for the broker. Defaults to null, which falls back to the AWS-owned default key. | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | Name for the broker and its security group. | `string` | n/a | yes |
| <a name="input_password"></a> [password](#input\_password) | Admin password for the broker. Must be 12-250 characters -- Amazon MQ's own API requirement, enforced by this module's precondition. | `string` | n/a | yes |
| <a name="input_private_subnet_ids"></a> [private\_subnet\_ids](#input\_private\_subnet\_ids) | Only the first subnet is used (single-instance deployment) | `list(string)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags applied to the broker and its security group. | `map(string)` | `{}` | no |
| <a name="input_username"></a> [username](#input\_username) | Admin username for the broker. | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC to place the broker and its security group in. | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_broker_id"></a> [broker\_id](#output\_broker\_id) | Broker ID. |
| <a name="output_endpoints"></a> [endpoints](#output\_endpoints) | Connection endpoints for each broker instance (a single instance, since this module always deploys SINGLE\_INSTANCE). |
<!-- END_TF_DOCS -->
