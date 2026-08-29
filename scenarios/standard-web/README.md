# standard-web

**카테고리**: 웹/API
**설명**: ALB+ECS Fargate+RDS+S3 조합의 일반적인 웹 서비스. 최초 예시(live/example-dev)의 축소판 대상.

## 상태

composed — `vpc`, `ecr`, `alb`, `ecs-service`, `rds-postgres`, `observability` 모듈을 실제로 조합했고 `terraform validate` 통과. `container_image` 기본값은 즉시 plan/apply해볼 수 있도록 공개 nginx 이미지로 채워뒀다 — 실제 앱을 배포하려면 `ecr` 모듈이 만든 리포지토리에 이미지를 푸시하고 `container_image` 변수를 그 URL로 바꿀 것.

## 관련 모듈

vpc, ecr, alb, ecs-service, rds-postgres, observability

## 사용 방법

`live/<project-name>/`으로 복사한 뒤 그 프로젝트만의 `terraform.tfvars`와 `backend.tf`를 채워 넣는다.

## 참고자료

- [AWS Well-Architected Framework](https://docs.aws.amazon.com/wellarchitected/latest/framework/welcome.html)
- 관련 모듈 문서: `vpc`, `ecr`, `alb`, `ecs-service`, `rds-postgres`, `observability`

<!-- BEGIN_TF_DOCS -->
## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones) | Availability zones to spread subnets across (multi-AZ by default for spike resilience) | `list(string)` | <pre>[<br/>  "ap-northeast-2a",<br/>  "ap-northeast-2c"<br/>]</pre> | no |
| <a name="input_container_image"></a> [container\_image](#input\_container\_image) | Placeholder public image so this plans/applies out of the box. Swap for your app's image in modules.ecr's repository once you have one. | `string` | `"public.ecr.aws/nginx/nginx:1.27"` | no |
| <a name="input_name"></a> [name](#input\_name) | Base name for every module in the stack (VPC, ECR, ALB, ECS service, RDS, observability). | `string` | `"standard-web"` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_alb_dns_name"></a> [alb\_dns\_name](#output\_alb\_dns\_name) | Public DNS name of the ALB fronting the ECS service. |
| <a name="output_ecr_repository_url"></a> [ecr\_repository\_url](#output\_ecr\_repository\_url) | URI to push the application's container image to before ecs\_service can pull it. |
| <a name="output_rds_endpoint"></a> [rds\_endpoint](#output\_rds\_endpoint) | Connection endpoint (host:port) of the Postgres instance. |
<!-- END_TF_DOCS -->