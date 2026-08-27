# canary-deployment

**카테고리**: 컨테이너/배포전략
**설명**: 점진적 트래픽 전환 기반 카나리 배포(Argo Rollouts/App Mesh 등).

## 상태

composed — 지금은 `vpc`+`eks`+`observability`뿐인 베이스 클러스터다. `terraform validate` 통과. **카나리 배포 메커니즘(Argo Rollouts 또는 App Mesh/Istio 트래픽 분할) 자체는 아직 없음** — 이건 Helm 릴리스+CRD가 필요해서 `eks` 모듈처럼 Terraform의 `helm`/`kubernetes` provider가 있어야 하는 더 큰 작업이다. 지금은 그 위에 올라갈 클러스터만 준비된 상태.

## 관련 모듈

vpc, eks, observability

## 참고자료

- [Argo Rollouts 공식 문서](https://argoproj.github.io/argo-rollouts/) (AWS 서비스는 아니지만 카나리 배포의 표준 OSS 도구)
- 관련 모듈 문서: `vpc`, `eks`, `observability`

<!-- BEGIN_TF_DOCS -->
## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones) | n/a | `list(string)` | <pre>[<br/>  "ap-northeast-2a",<br/>  "ap-northeast-2c"<br/>]</pre> | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"canary-deployment"` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_cluster_endpoint"></a> [cluster\_endpoint](#output\_cluster\_endpoint) | n/a |
<!-- END_TF_DOCS -->