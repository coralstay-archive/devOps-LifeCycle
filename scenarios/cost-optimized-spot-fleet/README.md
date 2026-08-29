# cost-optimized-spot-fleet

**카테고리**: 운영/비용
**설명**: Spot 인스턴스/Savings Plan을 활용해 비용을 최적화하는 컴퓨트 구성.

## 상태

composed — 지금은 `vpc`+`ecs-service` 기본 조합일 뿐이다. `terraform validate` 통과. **Spot 자체는 아직 배선되지 않음** — `ecs-service` 모듈은 Fargate(온디맨드)만 지원하고 Fargate Spot capacity provider 옵션이 없다. 실제 비용 최적화를 하려면 `ecs-service` 모듈에 `capacity_provider_strategy`(FARGATE_SPOT 비중)를 추가하거나, EKS 기반이면 `eks` 모듈의 노드 그룹에 `capacity_type = "SPOT"`을 추가해야 한다.

## 관련 모듈

vpc, ecs-service

## 참고자료

- [EC2 스팟 인스턴스 사용 설명서](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-spot-instances.html)
- [ECS Fargate 용량 공급자(Fargate Spot 포함)](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/fargate-capacity-providers.html)
- 관련 모듈 문서: `vpc`, `ecs-service`

<!-- BEGIN_TF_DOCS -->
## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones) | Availability zones for the vpc module to spread subnets across (multi-AZ by default). | `list(string)` | <pre>[<br/>  "ap-northeast-2a",<br/>  "ap-northeast-2c"<br/>]</pre> | no |
| <a name="input_container_image"></a> [container\_image](#input\_container\_image) | Container image URI for the ecs-service task definition (e.g. from the ecr module's repository\_url output). | `string` | `"public.ecr.aws/nginx/nginx:1.27"` | no |
| <a name="input_name"></a> [name](#input\_name) | Name prefix passed through to every module this scenario composes (vpc, ecs-service). | `string` | `"cost-optimized-spot-fleet"` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_cluster_id"></a> [cluster\_id](#output\_cluster\_id) | ECS cluster ID -- currently plain on-demand Fargate (see this scenario's README for why Spot/FARGATE\_SPOT isn't wired in yet). |
<!-- END_TF_DOCS -->