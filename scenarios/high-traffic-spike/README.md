# high-traffic-spike

**카테고리**: 웹/API
**설명**: 구글/스포티파이급 급격한 트래픽 스파이크에 대응하는 구성.

## 상태

composed — `vpc`, `eks`, `elasticache-redis`, `msk-kafka`, `observability` 조합, `terraform validate` 통과.

**알려진 제약**: `eks` 모듈이 아직 노드 보안그룹을 출력하지 않아서, redis/kafka의 `allowed_security_group_ids`를 자동으로 연결하지 못했다 — 배포 후 EKS 노드 보안그룹을 수동으로 redis/kafka 보안그룹에 추가해야 실제로 통신 가능하다. Karpenter도 `eks` 모듈 자체의 제약으로 아직 없음(해당 모듈 README 참고).

## 관련 모듈

vpc, eks, elasticache-redis, msk-kafka, observability

## 참고자료

- [Well-Architected: Reliability Pillar](https://docs.aws.amazon.com/wellarchitected/latest/reliability-pillar/reliability-pillar.html)
- 관련 모듈 문서: `eks`(Karpenter 링크 포함), `elasticache-redis`, `msk-kafka`, `observability`

<!-- BEGIN_TF_DOCS -->
## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones) | n/a | `list(string)` | <pre>[<br/>  "ap-northeast-2a",<br/>  "ap-northeast-2c"<br/>]</pre> | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"high-traffic-spike"` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_eks_cluster_endpoint"></a> [eks\_cluster\_endpoint](#output\_eks\_cluster\_endpoint) | n/a |
| <a name="output_kafka_bootstrap_brokers_tls"></a> [kafka\_bootstrap\_brokers\_tls](#output\_kafka\_bootstrap\_brokers\_tls) | n/a |
| <a name="output_redis_primary_endpoint"></a> [redis\_primary\_endpoint](#output\_redis\_primary\_endpoint) | n/a |
<!-- END_TF_DOCS -->