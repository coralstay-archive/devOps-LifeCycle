# waf-shield

Web ACL with the AWS Managed Common Rule Set, associated with an ALB by default (`scope = "REGIONAL"`). For CloudFront, set `scope = "CLOUDFRONT"` (provider must be us-east-1) and wire `web_acl_arn` into the `cloudfront` module's distribution directly instead of relying on this module's association resource. Shield Advanced protection is opt-in via `enable_shield_advanced` and requires an active subscription.

## Status

Implemented (minimal): one managed rule group.

<!-- BEGIN_TF_DOCS -->
## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_enable_shield_advanced"></a> [enable\_shield\_advanced](#input\_enable\_shield\_advanced) | Requires an active Shield Advanced subscription on the account | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | n/a | yes |
| <a name="input_resource_arn"></a> [resource\_arn](#input\_resource\_arn) | ALB ARN to associate with (only used when scope = REGIONAL; CloudFront attaches via its own web\_acl\_id argument instead) | `string` | `null` | no |
| <a name="input_scope"></a> [scope](#input\_scope) | REGIONAL (for ALB/API Gateway) or CLOUDFRONT. CLOUDFRONT requires the provider to be in us-east-1. | `string` | `"REGIONAL"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_web_acl_arn"></a> [web\_acl\_arn](#output\_web\_acl\_arn) | n/a |
| <a name="output_web_acl_id"></a> [web\_acl\_id](#output\_web\_acl\_id) | n/a |
<!-- END_TF_DOCS -->
