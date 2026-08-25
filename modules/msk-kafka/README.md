# msk-kafka

Managed Kafka cluster (Amazon MSK), TLS-only client access, default 2 brokers across 2 AZs.

## What Kafka is, briefly

Kafka is a distributed log: producers append to **topics**, split into **partitions** for parallelism; consumers track their own read position (**offset**) and messages aren't deleted on read, so multiple independent consumers can replay the same stream. Good fit for: multi-consumer event architectures, CDC pipelines, buffering write spikes.

Topic creation itself isn't a Terraform-managed resource here — create topics with the Kafka CLI/`kafka-topics.sh` or a client library against the `bootstrap_brokers_tls` output, since topic lifecycle (partition count changes, etc.) is usually operational, not IaC.

## Status

Implemented (minimal): cluster + TLS encryption in transit, no topics.

## Not yet included

MSK Serverless option, SASL/IAM auth, per-topic partition/retention management, auto-scaling storage policy.

<!-- BEGIN_TF_DOCS -->
## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_allowed_security_group_ids"></a> [allowed\_security\_group\_ids](#input\_allowed\_security\_group\_ids) | n/a | `list(string)` | `[]` | no |
| <a name="input_broker_instance_type"></a> [broker\_instance\_type](#input\_broker\_instance\_type) | n/a | `string` | `"kafka.t3.small"` | no |
| <a name="input_broker_volume_size"></a> [broker\_volume\_size](#input\_broker\_volume\_size) | n/a | `number` | `100` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | n/a | `string` | n/a | yes |
| <a name="input_kafka_version"></a> [kafka\_version](#input\_kafka\_version) | n/a | `string` | `"3.7.x"` | no |
| <a name="input_number_of_broker_nodes"></a> [number\_of\_broker\_nodes](#input\_number\_of\_broker\_nodes) | Must be a multiple of the number of subnets (AZs) | `number` | `2` | no |
| <a name="input_private_subnet_ids"></a> [private\_subnet\_ids](#input\_private\_subnet\_ids) | Needs >= 2 AZs | `list(string)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | `{}` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_bootstrap_brokers_tls"></a> [bootstrap\_brokers\_tls](#output\_bootstrap\_brokers\_tls) | n/a |
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | n/a |
| <a name="output_zookeeper_connect_string"></a> [zookeeper\_connect\_string](#output\_zookeeper\_connect\_string) | n/a |
<!-- END_TF_DOCS -->
