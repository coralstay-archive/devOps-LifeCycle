# alb

Application Load Balancer + one target group (IP target type, for Fargate). Pass `target_group_arn` output into `ecs-service`. Without `certificate_arn`, HTTP forwards directly (fine for `live/example-dev`-style testing); set `certificate_arn` (from the `acm` module) in anything real to get HTTPS + HTTP→HTTPS redirect.

## Status

Implemented (minimal). One target group only — for multiple services behind one ALB, use listener rules (not yet included).

## Not yet included

Checkov/Trivy findings that are real, accepted trade-offs, not gaps that slipped through unnoticed:
- **Deletion protection off by default** — `enable_deletion_protection` (default `false`) so `terraform destroy` works cleanly for a scaffold/demo stack. Flip on for anything real.
- **HTTP allowed / not forced to HTTPS-only** — intentional: without `certificate_arn`, HTTP forwards directly so `live/example-dev`-style testing doesn't require a cert. This is a real gap only if you deploy without `certificate_arn` in production.
- **Egress not scoped down (0.0.0.0/0)** — see the security group resource's inline comment.

**Access logging is now configurable via `access_logs_bucket`/`access_logs_prefix`** (both default `null`, i.e. off) — this module still doesn't create the destination bucket itself, since the bucket needs the ELB service account's specific log-delivery bucket policy attached and is naturally shared account-level infrastructure rather than something one ALB should own the lifecycle of. Point it at an existing properly-configured bucket (e.g. from `modules/s3-bucket` plus that bucket policy, wired up separately) to enable it.

## 런타임 불변식 (precondition/postcondition)

`aws_lb.this`에 `precondition`을 달아, `public_subnet_ids`가 최소 2개 AZ에 걸쳐 있는지 검증한다 — 이건 스타일이 아니라 실제 ALB API 요구사항이다.

## 공식문서

- [Application Load Balancer 소개](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/introduction.html)
- Terraform: [`aws_lb`](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb), [`aws_lb_target_group`](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group), [`aws_lb_listener`](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener)

<!-- BEGIN_TF_DOCS -->
## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_access_logs_bucket"></a> [access\_logs\_bucket](#input\_access\_logs\_bucket) | Name of an existing S3 bucket to receive ALB access logs (must already have the ELB service account's log-delivery bucket policy attached -- this module doesn't create that bucket). Null disables access logging. | `string` | `null` | no |
| <a name="input_access_logs_prefix"></a> [access\_logs\_prefix](#input\_access\_logs\_prefix) | S3 key prefix for access logs, used only when access\_logs\_bucket is set. | `string` | `null` | no |
| <a name="input_certificate_arn"></a> [certificate\_arn](#input\_certificate\_arn) | ACM certificate ARN. If set, adds an HTTPS listener and redirects HTTP to it. If null, HTTP forwards directly. | `string` | `null` | no |
| <a name="input_enable_deletion_protection"></a> [enable\_deletion\_protection](#input\_enable\_deletion\_protection) | Blocks accidental/automated deletion of the load balancer. Off by default so terraform destroy works cleanly for a scaffold/demo stack — flip on for anything real. | `bool` | `false` | no |
| <a name="input_health_check_path"></a> [health\_check\_path](#input\_health\_check\_path) | HTTP path the target group's health check requests. | `string` | `"/"` | no |
| <a name="input_name"></a> [name](#input\_name) | Name used for the load balancer, target group, and security group. | `string` | n/a | yes |
| <a name="input_public_subnet_ids"></a> [public\_subnet\_ids](#input\_public\_subnet\_ids) | Public subnet IDs for the ALB itself -- must span at least 2 AZs, an ALB API requirement enforced by this module's precondition. | `list(string)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags applied to the load balancer, target group, and security group. | `map(string)` | `{}` | no |
| <a name="input_target_port"></a> [target\_port](#input\_target\_port) | Port the target group forwards traffic to on registered targets. | `number` | `8080` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC to place the ALB, target group, and security group in. | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_arn"></a> [arn](#output\_arn) | Full ARN of the load balancer. |
| <a name="output_arn_suffix"></a> [arn\_suffix](#output\_arn\_suffix) | Shortened ARN suffix used by CloudWatch metrics/dashboards for this ALB. |
| <a name="output_dns_name"></a> [dns\_name](#output\_dns\_name) | The ALB's public DNS name -- point a Route53 alias record at this. |
| <a name="output_listener_arn"></a> [listener\_arn](#output\_listener\_arn) | The externally-facing listener: HTTPS if certificate\_arn was set, else HTTP |
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | Security group ID for the ALB itself -- reference this from a backend module's ingress rules to scope access to traffic from this ALB only. |
| <a name="output_target_group_arn"></a> [target\_group\_arn](#output\_target\_group\_arn) | ARN of the single target group -- feed into ecs-service to register tasks against it. |
| <a name="output_target_group_name"></a> [target\_group\_name](#output\_target\_group\_name) | Name of the single target group. |
<!-- END_TF_DOCS -->
