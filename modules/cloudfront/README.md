# cloudfront

CDN in front of an S3 origin via Origin Access Control (OAC — the current recommended approach, not the older OAI). Pair with the `s3-bucket` module's bucket policy to allow this distribution to read it (not included here — add a bucket policy referencing `aws_cloudfront_distribution.this.arn` when wiring up `static-site-cdn`).

## Status

Implemented (minimal): single-origin by default (opt into a second, failover origin — see below), no custom error pages, no cache invalidation automation.

## Not yet included

**WAF, geo restriction, and origin failover are now configurable, all off/null by default (no behavior change unless set):**
- `web_acl_id` — associate a `waf-shield` module output (`scope = "CLOUDFRONT"`, must be created in `us-east-1`). Still not wired together automatically since not every static site needs WAF rules — pass it explicitly from a scenario.
- `geo_restriction_type` / `geo_restriction_locations` — set type to `"whitelist"` or `"blacklist"` plus ISO 3166-1-alpha-2 country codes to block/allow specific countries.
- `failover_origin_domain_name` — set to a second S3 bucket's domain name (e.g. a cross-region-replicated bucket) to get a real `origin_group` with `403`/`404`/`5xx` failover criteria. Reuses the same `origin_access_control` for both origins since OAC is just a generic SigV4 signing config, not tied to a specific bucket. `null` (default) keeps this a plain single-origin distribution.

**Access logging is now configurable via `logging_bucket_domain_name`/`logging_prefix`** (both default `null`, i.e. off) — same bring-your-own-bucket reasoning as `alb`'s `access_logs_bucket`: the bucket needs ACLs enabled and write access granted to CloudFront's log-delivery account, which this module doesn't configure itself.

Checkov/Trivy findings that are real, accepted trade-offs:
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
| <a name="input_aliases"></a> [aliases](#input\_aliases) | Custom domain names (CNAMEs) this distribution answers for. Required (non-empty) whenever certificate\_arn is set -- enforced by a precondition. | `list(string)` | `[]` | no |
| <a name="input_certificate_arn"></a> [certificate\_arn](#input\_certificate\_arn) | ACM certificate ARN in us-east-1. Leave null to use the default CloudFront certificate (no custom domain). | `string` | `null` | no |
| <a name="input_failover_origin_domain_name"></a> [failover\_origin\_domain\_name](#input\_failover\_origin\_domain\_name) | Domain name of a second S3 origin (e.g. bucket\_regional\_domain\_name of a cross-region-replicated bucket) to fail over to on 403/404/5xx from the primary origin. Null (default) keeps this a single-origin distribution. | `string` | `null` | no |
| <a name="input_geo_restriction_locations"></a> [geo\_restriction\_locations](#input\_geo\_restriction\_locations) | ISO 3166-1-alpha-2 country codes for geo\_restriction\_type whitelist/blacklist. Ignored when geo\_restriction\_type is "none". | `list(string)` | `[]` | no |
| <a name="input_geo_restriction_type"></a> [geo\_restriction\_type](#input\_geo\_restriction\_type) | CloudFront geo restriction mode: "none", "whitelist", or "blacklist". | `string` | `"none"` | no |
| <a name="input_logging_bucket_domain_name"></a> [logging\_bucket\_domain\_name](#input\_logging\_bucket\_domain\_name) | S3 bucket regional domain name to receive access logs (must already have ACLs enabled and write access granted to CloudFront's log-delivery account -- this module doesn't create/configure that bucket). Null disables access logging. | `string` | `null` | no |
| <a name="input_logging_prefix"></a> [logging\_prefix](#input\_logging\_prefix) | S3 key prefix for access logs, used only when logging\_bucket\_domain\_name is set. | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | Name for the origin access control and used as the primary origin's origin\_id. | `string` | n/a | yes |
| <a name="input_origin_domain_name"></a> [origin\_domain\_name](#input\_origin\_domain\_name) | e.g. an S3 bucket's bucket\_regional\_domain\_name | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags applied to the distribution. | `map(string)` | `{}` | no |
| <a name="input_web_acl_id"></a> [web\_acl\_id](#input\_web\_acl\_id) | ARN of a CLOUDFRONT-scope WAF web ACL (e.g. from modules/waf-shield) to associate with this distribution. Null means no WAF in front. | `string` | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_distribution_arn"></a> [distribution\_arn](#output\_distribution\_arn) | Distribution ARN -- reference this from the origin S3 bucket's policy to allow this distribution to read it via OAC. |
| <a name="output_distribution_id"></a> [distribution\_id](#output\_distribution\_id) | Distribution ID -- needed for cache invalidations and referencing this distribution elsewhere. |
| <a name="output_domain_name"></a> [domain\_name](#output\_domain\_name) | CloudFront's assigned domain name (e.g. dxxxx.cloudfront.net) -- point a Route53 alias record at this, or use it directly. |
<!-- END_TF_DOCS -->
