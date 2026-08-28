# acm

DNS-validated ACM certificate, using a Route53 zone (pass `zone_id` from the `route53` module) to auto-create the validation records.

## Status

Implemented (minimal).

## 런타임 불변식 (precondition/postcondition)

`aws_acm_certificate.this`에 `precondition`을 달아, `subject_alternative_names`에 `domain_name`이 중복으로 들어가지 않았는지 검증한다.

## 공식문서

- [AWS Certificate Manager 개요](https://docs.aws.amazon.com/acm/latest/userguide/acm-overview.html)
- Terraform: [`aws_acm_certificate`](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate)

<!-- BEGIN_TF_DOCS -->
## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | Primary domain name the certificate covers (DNS validated via Route53). | `string` | n/a | yes |
| <a name="input_subject_alternative_names"></a> [subject\_alternative\_names](#input\_subject\_alternative\_names) | Additional domain names the certificate covers besides domain\_name. Must not repeat domain\_name itself -- enforced by a precondition. | `list(string)` | `[]` | no |
| <a name="input_zone_id"></a> [zone\_id](#input\_zone\_id) | Route53 zone ID used for DNS validation (see the route53 module's zone\_id output) | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_certificate_arn"></a> [certificate\_arn](#output\_certificate\_arn) | ARN of the validated certificate (only resolves once DNS validation completes) -- feed into alb/cloudfront's certificate\_arn. |
<!-- END_TF_DOCS -->
