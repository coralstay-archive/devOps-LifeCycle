# iam

Generic IAM role assumable by one or more AWS service principals (`ec2.amazonaws.com`, `ecs-tasks.amazonaws.com`, etc.), with managed and/or inline policy attachment. This is the general-purpose version of the role pattern that `ecs-service`, `lambda`, `eks`, `glue`, `sagemaker`, and others each currently hardcode inline for their own specific service — use this one directly for anything that doesn't already have a dedicated module (e.g. `ec2`), or as a reference for the pattern.

Not to be confused with `iam-github-oidc`, which handles federated (OIDC) trust for CI, not a service principal.

## The two policies every IAM role has

- **Trust policy** (`assume_role_policy`, built from `assume_role_services` here) — *who* can assume this role. Answers "who is allowed to put this role on."
- **Permission policy** (`managed_policy_arns` / `inline_policy_json`) — *what* the role can do once assumed. Answers "what can they do while wearing it."
These are two separate documents attached to the same role; mixing them up is the most common IAM confusion point.

## Managed vs inline policy

Prefer a managed policy (AWS-owned or customer-managed) when one fits — it's reusable, versioned, and shows up cleanly in IAM's policy list. Reach for `inline_policy_json` only when the permission is so specific to this one role that a standalone managed policy would never be reused.

## Status

Implemented (minimal).

## Not yet included

Federated/OIDC trust (see `iam-github-oidc` instead), permission boundaries, resource-based policy conditions beyond the basic `sts:AssumeRole` trust statement.

## 공식문서

- [IAM 사용 설명서](https://docs.aws.amazon.com/IAM/latest/UserGuide/introduction.html)
- [IAM 역할](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles.html)
- Terraform: [`aws_iam_role`](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role), [`aws_iam_policy_document`](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document)

<!-- BEGIN_TF_DOCS -->
## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_assume_role_services"></a> [assume\_role\_services](#input\_assume\_role\_services) | AWS service principals allowed to assume this role, e.g. ["ec2.amazonaws.com"] | `list(string)` | n/a | yes |
| <a name="input_inline_policy_json"></a> [inline\_policy\_json](#input\_inline\_policy\_json) | Optional inline policy JSON for permissions with no suitable managed policy. Prefer managed\_policy\_arns when one exists. | `string` | `null` | no |
| <a name="input_managed_policy_arns"></a> [managed\_policy\_arns](#input\_managed\_policy\_arns) | Managed policy ARNs to attach | `list(string)` | `[]` | no |
| <a name="input_name"></a> [name](#input\_name) | Role name | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_role_arn"></a> [role\_arn](#output\_role\_arn) | n/a |
| <a name="output_role_name"></a> [role\_name](#output\_role\_name) | n/a |
<!-- END_TF_DOCS -->
