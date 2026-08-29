# private-vpc-only

**카테고리**: 네트워크/보안
**설명**: 퍼블릭 서브넷 없이 PrivateLink/VPN으로만 통신하는 완전 사설 VPC.

## 상태

composed — `vpc`(NAT 게이트웨이 비활성화)+`vpc-endpoints`(S3/DynamoDB 게이트웨이 + ECR/CloudWatch Logs 인터페이스) 조합, `terraform validate` 통과. 이 조합만으로는 인터넷 아웃바운드가 전혀 없다 — 필요하면 VPN/Transit Gateway를 별도로 추가할 것(아직 모듈 없음).

## 관련 모듈

vpc, vpc-endpoints

## 참고자료

- [AWS PrivateLink 개요](https://docs.aws.amazon.com/vpc/latest/privatelink/what-is-privatelink.html)
- 관련 모듈 문서: `vpc`, `vpc-endpoints`

<!-- BEGIN_TF_DOCS -->
## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones) | Availability zones to spread the VPC's subnets across. | `list(string)` | <pre>[<br/>  "ap-northeast-2a",<br/>  "ap-northeast-2c"<br/>]</pre> | no |
| <a name="input_name"></a> [name](#input\_name) | Name prefix applied to the VPC and its endpoints. | `string` | `"private-vpc-only"` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS region, used to build each VPC endpoint's service\_name (e.g. com.amazonaws.<region>.s3). | `string` | `"ap-northeast-2"` | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | CIDR block for the VPC -- also passed to modules/vpc-endpoints so its endpoint security group can scope ingress to this range. | `string` | `"10.0.0.0/16"` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_interface_endpoint_ids"></a> [interface\_endpoint\_ids](#output\_interface\_endpoint\_ids) | IDs of the interface VPC endpoints (e.g. ECR, CloudWatch Logs) created to fill the gaps a NAT gateway would otherwise cover. |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | VPC ID -- has no NAT gateway or internet route, only the VPC endpoints created below. |
<!-- END_TF_DOCS -->