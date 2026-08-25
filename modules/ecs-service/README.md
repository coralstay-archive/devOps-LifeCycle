# ecs-service

Single Fargate service: cluster + task definition + service, optional ALB target group attachment via `target_group_arn`.

## Status

Implemented (minimal). Pair with the `alb` module for `target_group_arn`.

## Not yet included

Service auto scaling policy, blue/green (CodeDeploy) — see `codedeploy` module for `scenarios/blue-green-deployment`.

<!-- BEGIN_TF_DOCS -->
## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_container_image"></a> [container\_image](#input\_container\_image) | n/a | `string` | n/a | yes |
| <a name="input_container_port"></a> [container\_port](#input\_container\_port) | n/a | `number` | `8080` | no |
| <a name="input_cpu"></a> [cpu](#input\_cpu) | n/a | `number` | `256` | no |
| <a name="input_desired_count"></a> [desired\_count](#input\_desired\_count) | n/a | `number` | `2` | no |
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
