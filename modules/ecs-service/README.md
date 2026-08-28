# ecs-service

Single Fargate service: cluster + task definition + service, optional ALB target group attachment via `target_group_arn`.

## Status

Implemented (minimal). Pair with the `alb` module for `target_group_arn`.

## Not yet included

Service auto scaling policy, blue/green (CodeDeploy) — see `codedeploy` module for `scenarios/blue-green-deployment`.

Checkov/Trivy findings that are real, accepted trade-offs:
- **Container Insights off by default** — a real cost trade-off, not a free flip: extra per-container CloudWatch metrics cost money at scale. Set `enable_container_insights = true` when a scenario needs per-container CPU/memory visibility beyond task-level metrics.
- **Egress not scoped down (0.0.0.0/0)** — see the security group resource's inline comment. Ingress *is* scoped to the ALB's security group when one is provided (`alb_security_group_id`).

## 런타임 불변식 (precondition/postcondition)

`aws_ecs_service.this`에 `precondition`을 달아, `private_subnet_ids`가 비어있지 않은지 검증한다.

## 공식문서

- [Amazon ECS 개발자 안내서](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/Welcome.html)
- Terraform: [`aws_ecs_service`](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service), [`aws_ecs_task_definition`](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition)

<!-- BEGIN_TF_DOCS -->
## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_alb_security_group_id"></a> [alb\_security\_group\_id](#input\_alb\_security\_group\_id) | ALB's security group ID (the alb module's security\_group\_id output). If set, container\_port ingress is scoped to only the ALB instead of 0.0.0.0/0. Leave null if there's no ALB in front of this service. | `string` | `null` | no |
| <a name="input_container_image"></a> [container\_image](#input\_container\_image) | n/a | `string` | n/a | yes |
| <a name="input_container_port"></a> [container\_port](#input\_container\_port) | n/a | `number` | `8080` | no |
| <a name="input_cpu"></a> [cpu](#input\_cpu) | n/a | `number` | `256` | no |
| <a name="input_desired_count"></a> [desired\_count](#input\_desired\_count) | n/a | `number` | `2` | no |
| <a name="input_enable_container_insights"></a> [enable\_container\_insights](#input\_enable\_container\_insights) | Per-container CPU/memory metrics beyond task-level. Real per-cluster cost when enabled. | `bool` | `false` | no |
| <a name="input_memory"></a> [memory](#input\_memory) | n/a | `number` | `512` | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | n/a | yes |
| <a name="input_private_subnet_ids"></a> [private\_subnet\_ids](#input\_private\_subnet\_ids) | n/a | `list(string)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | `{}` | no |
| <a name="input_target_group_arn"></a> [target\_group\_arn](#input\_target\_group\_arn) | ALB target group ARN to attach the service to. Leave null to run without a load balancer. | `string` | `null` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_cluster_id"></a> [cluster\_id](#output\_cluster\_id) | n/a |
| <a name="output_cluster_name"></a> [cluster\_name](#output\_cluster\_name) | n/a |
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | n/a |
| <a name="output_service_name"></a> [service\_name](#output\_service\_name) | n/a |
<!-- END_TF_DOCS -->
