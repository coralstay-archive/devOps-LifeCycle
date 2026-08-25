# cloudfront

CDN in front of an S3 origin via Origin Access Control (OAC — the current recommended approach, not the older OAI). Pair with the `s3-bucket` module's bucket policy to allow this distribution to read it (not included here — add a bucket policy referencing `aws_cloudfront_distribution.this.arn` when wiring up `static-site-cdn`).

## Status

Implemented (minimal): S3 origin only, no custom error pages, no cache invalidation automation.

<!-- BEGIN_TF_DOCS -->
## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_aliases"></a> [aliases](#input\_aliases) | n/a | `list(string)` | `[]` | no |
| <a name="input_certificate_arn"></a> [certificate\_arn](#input\_certificate\_arn) | ACM certificate ARN in us-east-1. Leave null to use the default CloudFront certificate (no custom domain). | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | n/a | yes |
| <a name="input_origin_domain_name"></a> [origin\_domain\_name](#input\_origin\_domain\_name) | e.g. an S3 bucket's bucket\_regional\_domain\_name | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_distribution_arn"></a> [distribution\_arn](#output\_distribution\_arn) | n/a |
| <a name="output_distribution_id"></a> [distribution\_id](#output\_distribution\_id) | n/a |
| <a name="output_domain_name"></a> [domain\_name](#output\_domain\_name) | n/a |
<!-- END_TF_DOCS -->
