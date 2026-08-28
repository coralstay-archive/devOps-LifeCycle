# vpc

Multi-AZ VPC with public/private subnets and one NAT gateway per AZ (spike-resilience default: avoids a single NAT gateway becoming a bottleneck/SPOF under bursty traffic).

## Status

Implemented (minimal). Used by `live/example-dev`.

## Inputs

See `variables.tf`. Key ones: `name`, `cidr_block`, `availability_zones`, `enable_nat_gateway`.

## Outputs

`vpc_id`, `public_subnet_ids`, `private_subnet_ids`.

## Not yet included

VPC endpoints (S3/ECR gateway/interface endpoints — see the `vpc-endpoints` module), IPv6. Add when a scenario needs them.

**Flow logs are opt-in** (`enable_flow_logs`, default `false`) — when on, logs REJECT-only traffic to a CloudWatch log group via a dedicated IAM role. REJECT-only (not ALL) is the cheapest useful default: it surfaces misconfigured security groups/NACLs without the volume/cost of logging every accepted packet too.

One Trivy finding that's intentional, not a gap: **"instances in a subnet receive a public IP by default"** — that's `map_public_ip_on_launch = true` on the *public* subnets specifically (the private subnets don't set this). A public subnet whose instances don't get public IPs isn't really public — this is the point of the subnet, not an oversight.

## 런타임 불변식 (precondition/postcondition)

`private_subnet_ids` 출력에 `precondition`을 달아, private 서브넷 개수가 항상 AZ 개수와 정확히 일치하는지 매 plan/apply마다 검증한다 (TLA+ 같은 별도 형식검증 도구 대신 Terraform 자체 기능으로 불변식을 표현한 예시 — `terraform test`가 "배포 전 한 번" 검증한다면, 이건 "매 적용마다" 검증한다).

## 공식문서

- [Amazon VPC 사용 설명서](https://docs.aws.amazon.com/vpc/latest/userguide/what-is-amazon-vpc.html)
- Terraform: [`aws_vpc`](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc), [`aws_subnet`](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet), [`aws_nat_gateway`](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway), [`aws_route_table`](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table)

<!-- BEGIN_TF_DOCS -->
## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones) | Availability zones to spread subnets across (multi-AZ by default for spike resilience) | `list(string)` | n/a | yes |
| <a name="input_cidr_block"></a> [cidr\_block](#input\_cidr\_block) | CIDR block for the VPC | `string` | `"10.0.0.0/16"` | no |
| <a name="input_enable_flow_logs"></a> [enable\_flow\_logs](#input\_enable\_flow\_logs) | Create VPC Flow Logs (REJECT traffic only) to a CloudWatch log group. Defaults to false — real ongoing CloudWatch Logs cost when on. | `bool` | `false` | no |
| <a name="input_enable_nat_gateway"></a> [enable\_nat\_gateway](#input\_enable\_nat\_gateway) | Create one NAT gateway per AZ so private subnets have outbound internet access | `bool` | `true` | no |
| <a name="input_name"></a> [name](#input\_name) | Name prefix applied to all resources created by this module | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags applied to all resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_private_route_table_ids"></a> [private\_route\_table\_ids](#output\_private\_route\_table\_ids) | Route table IDs backing the private subnets (for VPC gateway endpoints) |
| <a name="output_private_subnet_ids"></a> [private\_subnet\_ids](#output\_private\_subnet\_ids) | IDs of private subnets, one per AZ |
| <a name="output_public_subnet_ids"></a> [public\_subnet\_ids](#output\_public\_subnet\_ids) | IDs of public subnets, one per AZ |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | ID of the created VPC |
<!-- END_TF_DOCS -->