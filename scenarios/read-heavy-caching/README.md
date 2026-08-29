# read-heavy-caching

**카테고리**: 캐싱/성능
**설명**: Redis+CDN 조합으로 읽기 위주 트래픽의 스파이크를 분산.

## 상태

composed — `vpc`+`elasticache-redis`(1 primary + 2 replica)+`observability` 조합, `terraform validate` 통과. CDN 부분은 정적 자산이 있는 경우에만 의미가 있어 포함하지 않았다 — 필요하면 `cloudfront` 모듈을 오리진 서버 앞에 추가할 것.

## 관련 모듈

vpc, elasticache-redis, observability

## 참고자료

- [ElastiCache 캐싱 전략](https://docs.aws.amazon.com/AmazonElastiCache/latest/red-ug/Strategies.html)
- 관련 모듈 문서: `vpc`, `elasticache-redis`, `observability`

<!-- BEGIN_TF_DOCS -->
## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones) | Availability zones to spread the VPC's subnets and Redis nodes across. | `list(string)` | <pre>[<br/>  "ap-northeast-2a",<br/>  "ap-northeast-2c"<br/>]</pre> | no |
| <a name="input_name"></a> [name](#input\_name) | Name prefix applied to the VPC and Redis replication group. | `string` | `"read-heavy-caching"` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_redis_reader_endpoint"></a> [redis\_reader\_endpoint](#output\_redis\_reader\_endpoint) | Reader endpoint for the Redis replication group -- routes to a replica, for spreading read traffic off the primary. |
<!-- END_TF_DOCS -->