# ecs-fargate-microservices

**카테고리**: 컨테이너/배포전략
**설명**: 여러 ECS Fargate 서비스로 구성된 마이크로서비스 묶음.

## 상태

composed — 공유 `vpc` 위에 `services` 변수(기본값: service-a, service-b) 개수만큼 `alb`+`ecs-service` 쌍을 `for_each`로 생성. `terraform validate` 통과. 서비스마다 별도 ALB를 쓰는 건 가장 단순한 접근이라 그렇게 했다 — ALB 비용을 아끼려면 하나의 ALB에 리스너 규칙(path/host 기반 라우팅)으로 여러 서비스를 붙이는 구조로 바꿀 수 있다(현재는 미포함).

## 관련 모듈

vpc, alb (서비스당 1개), ecs-service (서비스당 1개)

## 참고자료

- 관련 모듈 문서: `vpc`, `alb`, `ecs-service`

<!-- BEGIN_TF_DOCS -->
## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones) | AZs the VPC's public/private subnets span -- needs >= 2 for the ALB/NAT gateway per-AZ requirements enforced by the modules this scenario composes. | `list(string)` | <pre>[<br/>  "ap-northeast-2a",<br/>  "ap-northeast-2c"<br/>]</pre> | no |
| <a name="input_container_image"></a> [container\_image](#input\_container\_image) | Placeholder image shared by all services for a quick smoke test | `string` | `"public.ecr.aws/nginx/nginx:1.27"` | no |
| <a name="input_name"></a> [name](#input\_name) | Base name used as the prefix/tag for every resource in this stack (VPC, ALBs, ECS services). | `string` | `"ecs-fargate-microservices"` | no |
| <a name="input_services"></a> [services](#input\_services) | One ALB + ECS service pair per entry | `list(string)` | <pre>[<br/>  "service-a",<br/>  "service-b"<br/>]</pre> | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_alb_dns_names"></a> [alb\_dns\_names](#output\_alb\_dns\_names) | Each service's ALB DNS name, keyed by entry in var.services -- one ALB per service, not shared. |
<!-- END_TF_DOCS -->