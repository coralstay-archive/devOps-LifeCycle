# zero-trust-edge

**카테고리**: 네트워크/보안
**설명**: WAF+Shield+보안그룹 강화로 제로 트러스트에 가까운 엣지 보안.

## 상태

composed — `vpc`+`alb`+`waf-shield`(ALB에 AWS Managed Common Rule Set 연결) 조합, `terraform validate` 통과. Shield Advanced는 기본 비활성화(`waf-shield` 모듈의 `enable_shield_advanced` 참고, 구독 필요).

## 관련 모듈

vpc, alb, waf-shield

## 참고자료

- [AWS 제로 트러스트](https://aws.amazon.com/security/zero-trust/)
- 관련 모듈 문서: `vpc`, `alb`, `waf-shield`

<!-- BEGIN_TF_DOCS -->
## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones) | n/a | `list(string)` | <pre>[<br/>  "ap-northeast-2a",<br/>  "ap-northeast-2c"<br/>]</pre> | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"zero-trust-edge"` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_alb_dns_name"></a> [alb\_dns\_name](#output\_alb\_dns\_name) | n/a |
| <a name="output_web_acl_arn"></a> [web\_acl\_arn](#output\_web\_acl\_arn) | n/a |
<!-- END_TF_DOCS -->