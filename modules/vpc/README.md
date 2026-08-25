# vpc

Multi-AZ VPC with public/private subnets and one NAT gateway per AZ (spike-resilience default: avoids a single NAT gateway becoming a bottleneck/SPOF under bursty traffic).

## Status

Implemented (minimal). Used by `live/example-dev`.

## Inputs

See `variables.tf`. Key ones: `name`, `cidr_block`, `availability_zones`, `enable_nat_gateway`.

## Outputs

`vpc_id`, `public_subnet_ids`, `private_subnet_ids`.

## Not yet included

VPC endpoints (S3/ECR gateway/interface endpoints), flow logs, IPv6. Add when a scenario needs them.

<!-- BEGIN_TF_DOCS -->
## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones) | Availability zones to spread subnets across (multi-AZ by default for spike resilience) | `list(string)` | n/a | yes |
| <a name="input_cidr_block"></a> [cidr\_block](#input\_cidr\_block) | CIDR block for the VPC | `string` | `"10.0.0.0/16"` | no |
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