# eks-multi-tenant-cluster

**카테고리**: 컨테이너/배포전략
**설명**: 네임스페이스 기반으로 여러 팀/서비스가 공유하는 EKS 클러스터.

## 상태

composed — `vpc`+`eks`(노드 3~6대로 여유 확보)+`observability` 조합, `terraform validate` 통과. 네임스페이스별 RBAC/리소스 쿼터는 Kubernetes 매니페스트 레이어의 몫이라 여기 포함하지 않았다.

## 관련 모듈

vpc, eks, observability

## 참고자료

- [EKS Best Practices: 멀티테넌시](https://docs.aws.amazon.com/eks/latest/best-practices/multi-tenancy.html)
- 관련 모듈 문서: `vpc`, `eks`, `observability`

<!-- BEGIN_TF_DOCS -->
## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones) | n/a | `list(string)` | <pre>[<br/>  "ap-northeast-2a",<br/>  "ap-northeast-2c"<br/>]</pre> | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"eks-multi-tenant-cluster"` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_cluster_endpoint"></a> [cluster\_endpoint](#output\_cluster\_endpoint) | n/a |
| <a name="output_node_role_arn"></a> [node\_role\_arn](#output\_node\_role\_arn) | n/a |
<!-- END_TF_DOCS -->