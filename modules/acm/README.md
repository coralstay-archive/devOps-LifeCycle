# acm

DNS-validated ACM certificate, using a Route53 zone (pass `zone_id` from the `route53` module) to auto-create the validation records.

## Status

Implemented (minimal).

<!-- BEGIN_TF_DOCS -->
## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | n/a | `string` | n/a | yes |
| <a name="input_subject_alternative_names"></a> [subject\_alternative\_names](#input\_subject\_alternative\_names) | n/a | `list(string)` | `[]` | no |
| <a name="input_zone_id"></a> [zone\_id](#input\_zone\_id) | Route53 zone ID used for DNS validation (see the route53 module's zone\_id output) | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_certificate_arn"></a> [certificate\_arn](#output\_certificate\_arn) | n/a |
<!-- END_TF_DOCS -->
