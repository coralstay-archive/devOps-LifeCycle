# amazon-mq

Managed RabbitMQ (default) or ActiveMQ, single-instance deployment. **Only use this if something needs to speak AMQP/MQTT/STOMP/OpenWire specifically** — e.g. migrating an app that already talks to RabbitMQ/ActiveMQ. For anything built fresh on AWS, `sns-sqs` is the default choice, not this module.

## Status

Implemented (minimal): single-instance, no active/standby HA (use `deployment_mode = "ACTIVE_STANDBY_MULTI_AZ"` for that, not yet parameterized here).

<!-- BEGIN_TF_DOCS -->
## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_allowed_security_group_ids"></a> [allowed\_security\_group\_ids](#input\_allowed\_security\_group\_ids) | n/a | `list(string)` | `[]` | no |
| <a name="input_engine_type"></a> [engine\_type](#input\_engine\_type) | RabbitMQ or ActiveMQ — pick this only if you need protocol compatibility with an existing broker; otherwise use sns-sqs | `string` | `"RabbitMQ"` | no |
| <a name="input_engine_version"></a> [engine\_version](#input\_engine\_version) | n/a | `string` | `"3.13"` | no |
| <a name="input_host_instance_type"></a> [host\_instance\_type](#input\_host\_instance\_type) | n/a | `string` | `"mq.t3.micro"` | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | n/a | yes |
| <a name="input_password"></a> [password](#input\_password) | n/a | `string` | n/a | yes |
| <a name="input_private_subnet_ids"></a> [private\_subnet\_ids](#input\_private\_subnet\_ids) | Only the first subnet is used (single-instance deployment) | `list(string)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | `{}` | no |
| <a name="input_username"></a> [username](#input\_username) | n/a | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_broker_id"></a> [broker\_id](#output\_broker\_id) | n/a |
| <a name="output_endpoints"></a> [endpoints](#output\_endpoints) | n/a |
<!-- END_TF_DOCS -->
