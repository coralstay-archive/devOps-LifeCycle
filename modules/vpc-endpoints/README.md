# vpc-endpoints

S3 + DynamoDB gateway endpoints (free) plus interface endpoints for ECR/CloudWatch Logs by default — enough for ECS/EKS tasks in fully private subnets to pull images and ship logs without a NAT gateway. Core of `private-vpc-only`.

## Status

Implemented (minimal). Add more `interface_services` (e.g. `secretsmanager`, `sts`) as a scenario needs them.

## 런타임 불변식 (precondition/postcondition)

`aws_vpc_endpoint.s3`에 `precondition`을 달아, `route_table_ids`가 비어있지 않은지 검증한다 — 라우트테이블에 안 붙은 게이트웨이 엔드포인트는 아무 데서도 못 쓴다.

## 공식문서

- [AWS PrivateLink 개요](https://docs.aws.amazon.com/vpc/latest/privatelink/what-is-privatelink.html)
- Terraform: [`aws_vpc_endpoint`](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint)

<!-- BEGIN_TF_DOCS -->
## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_interface_services"></a> [interface\_services](#input\_interface\_services) | Short service names, e.g. ecr.api, ecr.dkr, logs | `list(string)` | <pre>[<br/>  "ecr.api",<br/>  "ecr.dkr",<br/>  "logs"<br/>]</pre> | no |
| <a name="input_private_subnet_ids"></a> [private\_subnet\_ids](#input\_private\_subnet\_ids) | Subnets the interface endpoints' ENIs are placed in. | `list(string)` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | AWS region, used to build each endpoint's service\_name (e.g. com.amazonaws.<region>.s3). | `string` | n/a | yes |
| <a name="input_route_table_ids"></a> [route\_table\_ids](#input\_route\_table\_ids) | Route tables the S3/DynamoDB gateway endpoints attach to | `list(string)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags applied to the endpoints and the interface endpoints' security group. | `map(string)` | `{}` | no |
| <a name="input_vpc_cidr_block"></a> [vpc\_cidr\_block](#input\_vpc\_cidr\_block) | The VPC's CIDR block -- scopes the interface endpoints' security group ingress to traffic originating inside the VPC. | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC to attach the gateway and interface endpoints to. | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_interface_endpoint_ids"></a> [interface\_endpoint\_ids](#output\_interface\_endpoint\_ids) | Map of interface\_services entry -> its aws\_vpc\_endpoint ID (e.g. { "ecr.api" = "vpce-..." }). |
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | Security group attached to all interface endpoints -- reference this if another resource needs to be added as an allowed source beyond the VPC CIDR. |
<!-- END_TF_DOCS -->
