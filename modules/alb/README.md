# alb

Application Load Balancer + one target group (IP target type, for Fargate). Pass `target_group_arn` output into `ecs-service`. Without `certificate_arn`, HTTP forwards directly (fine for `live/example-dev`-style testing); set `certificate_arn` (from the `acm` module) in anything real to get HTTPS + HTTP→HTTPS redirect.

## Status

Implemented (minimal). One target group only — for multiple services behind one ALB, use listener rules (not yet included).

## Not yet included

Checkov/Trivy findings that are real, accepted trade-offs, not gaps that slipped through unnoticed:
- **Deletion protection off by default** — `enable_deletion_protection` (default `false`) so `terraform destroy` works cleanly for a scaffold/demo stack. Flip on for anything real.
- **Access logging not configured** — needs an S3 bucket + bucket policy to receive logs; add when a scenario needs request-level audit trails.
- **HTTP allowed / not forced to HTTPS-only** — intentional: without `certificate_arn`, HTTP forwards directly so `live/example-dev`-style testing doesn't require a cert. This is a real gap only if you deploy without `certificate_arn` in production.
- **Egress not scoped down (0.0.0.0/0)** — see the security group resource's inline comment.

## 런타임 불변식 (precondition/postcondition)

`aws_lb.this`에 `precondition`을 달아, `public_subnet_ids`가 최소 2개 AZ에 걸쳐 있는지 검증한다 — 이건 스타일이 아니라 실제 ALB API 요구사항이다.

## 공식문서

- [Application Load Balancer 소개](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/introduction.html)
- Terraform: [`aws_lb`](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb), [`aws_lb_target_group`](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group), [`aws_lb_listener`](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener)

<!-- BEGIN_TF_DOCS -->
## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_certificate_arn"></a> [certificate\_arn](#input\_certificate\_arn) | ACM certificate ARN. If set, adds an HTTPS listener and redirects HTTP to it. If null, HTTP forwards directly. | `string` | `null` | no |
| <a name="input_enable_deletion_protection"></a> [enable\_deletion\_protection](#input\_enable\_deletion\_protection) | Blocks accidental/automated deletion of the load balancer. Off by default so terraform destroy works cleanly for a scaffold/demo stack — flip on for anything real. | `bool` | `false` | no |
| <a name="input_health_check_path"></a> [health\_check\_path](#input\_health\_check\_path) | n/a | `string` | `"/"` | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | n/a | yes |
| <a name="input_public_subnet_ids"></a> [public\_subnet\_ids](#input\_public\_subnet\_ids) | n/a | `list(string)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | `{}` | no |
| <a name="input_target_port"></a> [target\_port](#input\_target\_port) | n/a | `number` | `8080` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_arn"></a> [arn](#output\_arn) | n/a |
| <a name="output_arn_suffix"></a> [arn\_suffix](#output\_arn\_suffix) | n/a |
| <a name="output_dns_name"></a> [dns\_name](#output\_dns\_name) | n/a |
| <a name="output_listener_arn"></a> [listener\_arn](#output\_listener\_arn) | The externally-facing listener: HTTPS if certificate\_arn was set, else HTTP |
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | n/a |
| <a name="output_target_group_arn"></a> [target\_group\_arn](#output\_target\_group\_arn) | n/a |
| <a name="output_target_group_name"></a> [target\_group\_name](#output\_target\_group\_name) | n/a |
<!-- END_TF_DOCS -->
