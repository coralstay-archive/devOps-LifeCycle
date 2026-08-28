# elasticache-redis

Redis replication group: 1 primary + replicas (count via `num_cache_nodes`), encrypted in transit and at rest.

## Status

Implemented (minimal). Cluster Mode (sharding) intentionally left out — this is a single shard with replicas, which covers most caching/session use cases. Add Cluster Mode when a scenario needs write throughput beyond one primary.

## Not yet included

Checkov/Trivy findings that are real, accepted trade-offs:
- **No `auth_token` (Redis AUTH)** — transit encryption is on (`transit_encryption_enabled = true`), but there's no password required to connect. Adding one properly means generating a random token and storing it in `secrets-manager` (never as a plain output, same pattern as this repo's other password-bearing modules) — a real feature addition, not a one-line flip.
- **Customer-managed KMS key** — encrypted at rest with the AWS-managed key by default. Add a `kms_key_id` variable if a scenario needs key rotation control/audit.
- **Egress not scoped down (0.0.0.0/0)** — see the security group resource's inline comment.

## Inputs / Outputs

See `variables.tf` / `outputs.tf`.

## 런타임 불변식 (precondition/postcondition)

`aws_elasticache_replication_group.this`에 `precondition`을 달아, `num_cache_nodes`가 1 이상인지 검증한다.

## 공식문서

- [ElastiCache for Redis 사용 설명서](https://docs.aws.amazon.com/AmazonElastiCache/latest/red-ug/WhatIs.html)
- [캐싱 전략](https://docs.aws.amazon.com/AmazonElastiCache/latest/red-ug/Strategies.html)
- Terraform: [`aws_elasticache_replication_group`](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_replication_group)

<!-- BEGIN_TF_DOCS -->
## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_allowed_security_group_ids"></a> [allowed\_security\_group\_ids](#input\_allowed\_security\_group\_ids) | n/a | `list(string)` | `[]` | no |
| <a name="input_name"></a> [name](#input\_name) | Name for the Redis replication group | `string` | n/a | yes |
| <a name="input_node_type"></a> [node\_type](#input\_node\_type) | n/a | `string` | `"cache.t4g.micro"` | no |
| <a name="input_num_cache_nodes"></a> [num\_cache\_nodes](#input\_num\_cache\_nodes) | Number of nodes (1 primary + N-1 replicas) | `number` | `2` | no |
| <a name="input_private_subnet_ids"></a> [private\_subnet\_ids](#input\_private\_subnet\_ids) | n/a | `list(string)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | `{}` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_primary_endpoint"></a> [primary\_endpoint](#output\_primary\_endpoint) | n/a |
| <a name="output_reader_endpoint"></a> [reader\_endpoint](#output\_reader\_endpoint) | n/a |
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | n/a |
<!-- END_TF_DOCS -->
