# multi-tenant-saas

**카테고리**: 웹/API
**설명**: 테넌트별 리소스/네임스페이스 격리가 필요한 SaaS 패턴.

## 상태

composed — `vpc`+`eks`+`rds-postgres`+`observability` 조합, `terraform validate` 통과. 테넌트별 격리 자체(네임스페이스, RBAC, 데이터 파티셔닝 전략)는 Kubernetes 매니페스트/애플리케이션 레이어의 몫이라 이 Terraform 조합에는 포함되지 않는다 — 여기서는 그 위에 올라갈 인프라 베이스만 제공한다.

## 관련 모듈

vpc, eks, rds-postgres, observability

## 참고자료

- [AWS 백서: SaaS Tenant Isolation Strategies](https://docs.aws.amazon.com/whitepapers/latest/saas-tenant-isolation-strategies/saas-tenant-isolation-strategies.html)
- 관련 모듈 문서: `vpc`, `eks`, `rds-postgres`, `observability`

<!-- BEGIN_TF_DOCS -->
## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones) | n/a | `list(string)` | <pre>[<br/>  "ap-northeast-2a",<br/>  "ap-northeast-2c"<br/>]</pre> | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"multi-tenant-saas"` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_eks_cluster_endpoint"></a> [eks\_cluster\_endpoint](#output\_eks\_cluster\_endpoint) | n/a |
| <a name="output_rds_endpoint"></a> [rds\_endpoint](#output\_rds\_endpoint) | n/a |
<!-- END_TF_DOCS -->