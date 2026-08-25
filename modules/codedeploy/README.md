# codedeploy

ECS blue/green deployment group. Needs two target groups (blue/green) already created on the same ALB — the `alb` module as-is only makes one, so `blue-green-deployment` will need a second `aws_lb_target_group` alongside it when this gets wired up for real.

## Status

Implemented (minimal): all-at-once traffic shift, auto-terminate old task set after 5 minutes.

## 공식문서

- [AWS CodeDeploy 사용 설명서](https://docs.aws.amazon.com/codedeploy/latest/userguide/welcome.html)
- [Amazon ECS 블루/그린 배포 만들기](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/deploy-blue-green-service.html)
- Terraform: [`aws_codedeploy_deployment_group`](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codedeploy_deployment_group)

<!-- BEGIN_TF_DOCS -->
## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_ecs_cluster_name"></a> [ecs\_cluster\_name](#input\_ecs\_cluster\_name) | n/a | `string` | n/a | yes |
| <a name="input_ecs_service_name"></a> [ecs\_service\_name](#input\_ecs\_service\_name) | n/a | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | n/a | yes |
| <a name="input_prod_listener_arn"></a> [prod\_listener\_arn](#input\_prod\_listener\_arn) | n/a | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | `{}` | no |
| <a name="input_target_group_blue_name"></a> [target\_group\_blue\_name](#input\_target\_group\_blue\_name) | n/a | `string` | n/a | yes |
| <a name="input_target_group_green_name"></a> [target\_group\_green\_name](#input\_target\_group\_green\_name) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_app_name"></a> [app\_name](#output\_app\_name) | n/a |
| <a name="output_deployment_group_name"></a> [deployment\_group\_name](#output\_deployment\_group\_name) | n/a |
<!-- END_TF_DOCS -->
