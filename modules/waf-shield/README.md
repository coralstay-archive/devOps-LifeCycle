# waf-shield

Web ACL with the AWS Managed Common Rule Set, associated with an ALB by default (`scope = "REGIONAL"`). For CloudFront, set `scope = "CLOUDFRONT"` (provider must be us-east-1) and wire `web_acl_arn` into the `cloudfront` module's distribution directly instead of relying on this module's association resource. Shield Advanced protection is opt-in via `enable_shield_advanced` and requires an active subscription.

## Status

Implemented (minimal): two managed rule groups (common rule set + known bad inputs, which covers Log4Shell/CVE-2021-44228).

## 런타임 불변식 (precondition/postcondition)

`aws_wafv2_web_acl.this`에 `precondition`을 달아, `scope`가 REGIONAL 또는 CLOUDFRONT인지 검증한다 — WAFv2의 유일한 유효값.

## 공식문서

- [AWS WAF 개발자 안내서](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html)
- [AWS Shield 개발자 안내서](https://docs.aws.amazon.com/waf/latest/developerguide/shield-chapter.html)
- Terraform: [`aws_wafv2_web_acl`](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/wafv2_web_acl)

<!-- BEGIN_TF_DOCS -->
## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_enable_shield_advanced"></a> [enable\_shield\_advanced](#input\_enable\_shield\_advanced) | Requires an active Shield Advanced subscription on the account | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the WAF web ACL. | `string` | n/a | yes |
| <a name="input_resource_arn"></a> [resource\_arn](#input\_resource\_arn) | ALB ARN to associate with (only used when scope = REGIONAL; CloudFront attaches via its own web\_acl\_id argument instead) | `string` | `null` | no |
| <a name="input_scope"></a> [scope](#input\_scope) | REGIONAL (for ALB/API Gateway) or CLOUDFRONT. CLOUDFRONT requires the provider to be in us-east-1. | `string` | `"REGIONAL"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags applied to the web ACL. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_web_acl_arn"></a> [web\_acl\_arn](#output\_web\_acl\_arn) | ARN of the web ACL -- pass this to a REGIONAL resource's web\_acl association (e.g. aws\_wafv2\_web\_acl\_association for an ALB) or to cloudfront's web\_acl\_id. |
| <a name="output_web_acl_id"></a> [web\_acl\_id](#output\_web\_acl\_id) | ID of the web ACL. |
<!-- END_TF_DOCS -->
