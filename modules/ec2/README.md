# ec2

Single EC2 instance: latest Amazon Linux 2023 by default, encrypted root volume, IMDSv2 enforced. No security group is created here — pass `security_group_ids` (empty list uses the VPC's default SG, which allows no inbound traffic).

## Status

Implemented (minimal).

## Not yet included

Auto Scaling Group (this is a single fixed instance, not a fleet), additional EBS volumes, EIP association, launch template. For anything that needs to scale, consider `ecs-service`/`eks` instead — this module exists for the cases that genuinely need a plain VM (bastion hosts, self-hosted tools, legacy lift-and-shift).

**Detailed monitoring off by default** — a real cost trade-off, not a free flip: 1-minute CloudWatch metrics cost extra per instance versus the free 5-minute default. Set `enable_detailed_monitoring = true` when a scenario actually needs finer-grained metrics.

## Security note

`key_name` defaults to `null`. Prefer **SSM Session Manager** (via an instance profile with `AmazonSSMManagedInstanceCore`) over SSH key pairs — no open port 22, no key distribution problem, and every session is logged in CloudTrail.

## 런타임 불변식 (precondition/postcondition)

`aws_instance.this`에 `precondition`을 달아, `root_volume_size`가 8GB 이상인지 검증한다(Amazon Linux 2023의 최소 루트 볼륨 크기).

## 공식문서

- [Amazon EC2 사용 설명서](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/concepts.html)
- [인스턴스 메타데이터 서비스(IMDSv2) 구성](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/configuring-instance-metadata-service.html)
- [AWS Systems Manager Session Manager](https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager.html)
- Terraform: [`aws_instance`](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance)

<!-- BEGIN_TF_DOCS -->
## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_ami_id"></a> [ami\_id](#input\_ami\_id) | Leave null to use the latest Amazon Linux 2023 AMI | `string` | `null` | no |
| <a name="input_associate_public_ip_address"></a> [associate\_public\_ip\_address](#input\_associate\_public\_ip\_address) | Assign a public IP on launch. Only meaningful in a public subnet -- keep false for anything in a private subnet. | `bool` | `false` | no |
| <a name="input_enable_detailed_monitoring"></a> [enable\_detailed\_monitoring](#input\_enable\_detailed\_monitoring) | 1-minute CloudWatch metrics instead of the free 5-minute default. Real per-instance cost when enabled. | `bool` | `false` | no |
| <a name="input_iam_instance_profile"></a> [iam\_instance\_profile](#input\_iam\_instance\_profile) | Instance profile name (e.g. from the iam module + an aws\_iam\_instance\_profile) | `string` | `null` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | EC2 instance type. | `string` | `"t3.micro"` | no |
| <a name="input_key_name"></a> [key\_name](#input\_key\_name) | EC2 key pair name for SSH access. Leave null to rely on SSM Session Manager instead (recommended). | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | Name tag for the instance. | `string` | n/a | yes |
| <a name="input_root_volume_size"></a> [root\_volume\_size](#input\_root\_volume\_size) | GB | `number` | `20` | no |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | Leave empty to use the VPC's default security group | `list(string)` | `[]` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | Subnet to launch the instance into. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags applied to the instance (merged with a Name tag from var.name). | `map(string)` | `{}` | no |
| <a name="input_user_data"></a> [user\_data](#input\_user\_data) | Shell script or cloud-init data to run on first boot. Leave null to skip. | `string` | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_instance_id"></a> [instance\_id](#output\_instance\_id) | ID of the EC2 instance. |
| <a name="output_private_ip"></a> [private\_ip](#output\_private\_ip) | Private IP address of the instance. |
| <a name="output_public_ip"></a> [public\_ip](#output\_public\_ip) | Public IP address of the instance (empty unless associate\_public\_ip\_address is true). |
<!-- END_TF_DOCS -->
