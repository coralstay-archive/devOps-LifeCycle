# multi-region-active-active

**카테고리**: 가용성/재해복구
**설명**: 두 개 이상의 리전에서 동시에 트래픽을 받는 능동-능동 구성.

## 상태

composed — 두 리전에 각각 `vpc` 모듈을 배포(provider alias 사용)하고 공용 `route53` 존을 두는 최소 뼈대. `terraform validate` 통과. 실제 능동-능동 트래픽 분산(레이턴시/장애조치 라우팅 정책, 데이터 복제)은 포함하지 않음 — `route53` 모듈에 레코드를 추가하고, 스택별로 데이터 계층(RDS 글로벌 데이터베이스 등)을 얹을 것.

이 저장소에서 유일하게 시나리오 레벨에 `providers.tf`를 둔 경우다 — 멀티 리전은 provider alias 없이는 표현이 안 되기 때문.

## 관련 모듈

vpc (x2, 리전별), route53

## 참고자료

- [AWS Prescriptive Guidance: Multi-Region Fundamentals](https://docs.aws.amazon.com/prescriptive-guidance/latest/aws-multi-region-fundamentals/)
- 관련 모듈 문서: `vpc`, `route53`

<!-- BEGIN_TF_DOCS -->
## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | Real domain you own — no sensible default | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Name prefix applied to resources in both regions. | `string` | `"multi-region-active-active"` | no |
| <a name="input_primary_azs"></a> [primary\_azs](#input\_primary\_azs) | Availability zones to spread the primary region's VPC subnets across. | `list(string)` | <pre>[<br/>  "ap-northeast-2a",<br/>  "ap-northeast-2c"<br/>]</pre> | no |
| <a name="input_primary_region"></a> [primary\_region](#input\_primary\_region) | Primary AWS region -- where the active-active pair's first VPC and its resources are provisioned. | `string` | `"ap-northeast-2"` | no |
| <a name="input_secondary_azs"></a> [secondary\_azs](#input\_secondary\_azs) | Availability zones to spread the secondary region's VPC subnets across. | `list(string)` | <pre>[<br/>  "us-east-1a",<br/>  "us-east-1b"<br/>]</pre> | no |
| <a name="input_secondary_region"></a> [secondary\_region](#input\_secondary\_region) | Secondary AWS region -- where the active-active pair's second, independent VPC and its resources are provisioned. | `string` | `"us-east-1"` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_primary_vpc_id"></a> [primary\_vpc\_id](#output\_primary\_vpc\_id) | VPC ID of the primary region's VPC. |
| <a name="output_secondary_vpc_id"></a> [secondary\_vpc\_id](#output\_secondary\_vpc\_id) | VPC ID of the secondary region's VPC. |
| <a name="output_zone_id"></a> [zone\_id](#output\_zone\_id) | Route53 hosted zone ID for domain\_name -- a single zone shared by both regions, since Route53 itself isn't region-scoped. |
<!-- END_TF_DOCS -->