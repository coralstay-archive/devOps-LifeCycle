# route53

Hosted zone (new or existing) + a map of DNS records.

## Status

Implemented (minimal).

## 런타임 불변식 (precondition/postcondition)

`aws_route53_record.this`에 `precondition`을 달아, 각 레코드의 `ttl`이 양수인지 검증한다.

## 공식문서

- [Amazon Route 53 개발자 안내서](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/Welcome.html)
- Terraform: [`aws_route53_zone`](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_zone), [`aws_route53_record`](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record)

<!-- BEGIN_TF_DOCS -->
## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_create_zone"></a> [create\_zone](#input\_create\_zone) | Create a new hosted zone. Set false to use an existing zone for domain\_name instead. | `bool` | `true` | no |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | The domain/zone name (e.g. "example.com"). Used to create a new hosted zone or look up an existing one, depending on create\_zone. | `string` | n/a | yes |
| <a name="input_records"></a> [records](#input\_records) | Map keyed by record name of { type, ttl, values } | <pre>map(object({<br/>    type   = string<br/>    ttl    = number<br/>    values = list(string)<br/>  }))</pre> | `{}` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_name_servers"></a> [name\_servers](#output\_name\_servers) | The zone's authoritative name servers, only populated when create\_zone is true (null for a looked-up existing zone -- you'd already have its name servers from wherever the domain was registered). |
| <a name="output_zone_id"></a> [zone\_id](#output\_zone\_id) | Hosted zone ID -- resolves to the newly created zone or the looked-up existing zone depending on create\_zone. |
<!-- END_TF_DOCS -->
