# cloudfront

CDN in front of an S3 origin via Origin Access Control (OAC — the current recommended approach, not the older OAI). Pair with the `s3-bucket` module's bucket policy to allow this distribution to read it (not included here — add a bucket policy referencing `aws_cloudfront_distribution.this.arn` when wiring up `static-site-cdn`).

## Status

Implemented (minimal): S3 origin only, no custom error pages, no cache invalidation automation.

## Not yet included

Checkov/Trivy findings that are real, accepted trade-offs:
- **No WAF attached** — see the `waf-shield` module for adding one (`scope = "CLOUDFRONT"`, must be created in `us-east-1`); not wired together by default since not every static site needs WAF rules.
- **No geo restriction** — add a `restrictions { geo_restriction { ... } }` block when a scenario needs to block/allow specific countries.
- **No origin failover** — needs a second origin + `origin_group`; this module is single-origin by design (see Status above).
- **Access logging not configured** — needs a dedicated S3 bucket to receive logs; add when a scenario needs request-level audit trails.
- **Default CloudFront certificate when `certificate_arn` is null** — this is TLS 1.0/1.1-compatible for backward compatibility with old clients, and CloudFront doesn't let you pin a higher minimum on the default cert path. Set `certificate_arn` to get TLS 1.2+ enforced (`minimum_protocol_version = "TLSv1.2_2021"`).

## 런타임 불변식 (precondition/postcondition)

`aws_cloudfront_distribution.this`에 `precondition`을 달아, `certificate_arn`을 설정했는데 `aliases`가 비어있는 모순 상태를 막는다.

## 공식문서

- [Amazon CloudFront 개발자 안내서](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/Introduction.html)
- Terraform: [`aws_cloudfront_distribution`](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_distribution)

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
