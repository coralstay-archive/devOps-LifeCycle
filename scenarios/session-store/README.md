# session-store

**카테고리**: 캐싱/성능
**설명**: ElastiCache를 세션 스토어로 사용하는 패턴.

## 상태

composed — `vpc`+`elasticache-redis`(기본값: 1 primary + 1 replica) 조합, `terraform validate` 통과.

## 관련 모듈

vpc, elasticache-redis

## 참고자료

- 관련 모듈 문서: `vpc`, `elasticache-redis`

<!-- BEGIN_TF_DOCS -->
## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones) | Availability zones to spread subnets across (multi-AZ by default for spike resilience) | `list(string)` | <pre>[<br/>  "ap-northeast-2a",<br/>  "ap-northeast-2c"<br/>]</pre> | no |
| <a name="input_name"></a> [name](#input\_name) | Base name for the VPC and the Redis replication group. | `string` | `"session-store"` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_redis_primary_endpoint"></a> [redis\_primary\_endpoint](#output\_redis\_primary\_endpoint) | Primary endpoint (read/write) of the Redis replication group backing session storage. |
<!-- END_TF_DOCS -->