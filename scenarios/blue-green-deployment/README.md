# blue-green-deployment

**카테고리**: 컨테이너/배포전략
**설명**: CodeDeploy/ALB 가중치 라우팅 기반 무중단 블루/그린 배포.

## 상태

composed — `vpc`+`alb`(blue 타겟그룹)+직접 선언한 green 타겟그룹+`ecs-service`+`codedeploy` 조합, `terraform validate` 통과.

**알려진 제약**: `ecs-service` 모듈은 `deployment_controller`를 지정하지 않아 기본값(ECS 네이티브 롤링 배포)을 쓴다. CodeDeploy가 실제로 트래픽을 전환하게 하려면 그 서비스의 `deployment_controller.type = "CODE_DEPLOY"`로 바꿔야 한다 — 지금은 `ecs-service` 모듈이 이 옵션을 노출하지 않으므로, 이 시나리오를 실제로 쓰려면 해당 모듈에 옵션을 추가하거나 여기서 별도 `aws_ecs_service` 리소스를 써야 한다.

## 관련 모듈

vpc, alb, ecs-service, codedeploy (+ 원시 `aws_lb_target_group.green`, 이유는 `main.tf` 주석 참고)

## 참고자료

- [Amazon ECS 블루/그린 배포 만들기](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/deploy-blue-green-service.html)
- 관련 모듈 문서: `vpc`, `alb`, `ecs-service`, `codedeploy`

<!-- BEGIN_TF_DOCS -->
## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones) | n/a | `list(string)` | <pre>[<br/>  "ap-northeast-2a",<br/>  "ap-northeast-2c"<br/>]</pre> | no |
| <a name="input_container_image"></a> [container\_image](#input\_container\_image) | n/a | `string` | `"public.ecr.aws/nginx/nginx:1.27"` | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"blue-green-deployment"` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_alb_dns_name"></a> [alb\_dns\_name](#output\_alb\_dns\_name) | n/a |
| <a name="output_codedeploy_app_name"></a> [codedeploy\_app\_name](#output\_codedeploy\_app\_name) | n/a |
<!-- END_TF_DOCS -->