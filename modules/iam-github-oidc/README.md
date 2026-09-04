# iam-github-oidc

Lets GitHub Actions assume an IAM role via OIDC federation instead of long-lived AWS access keys — the practical-level baseline for CI credentials (see plan's SRE/security notes).

## Status

Implemented (minimal). Used by CI workflows in `.github/workflows/`.

## Inputs

See `variables.tf`. Key ones: `github_org`, `github_repo`, `allowed_ref`, `role_name`, `policy_arns`.

`create_oidc_provider` defaults to `true` — set it to `false` on the second and later calls in the same AWS account, since an account can only have one `token.actions.githubusercontent.com` OIDC provider.

## Outputs

`role_arn`, `oidc_provider_arn`.

## Usage note

This repo only instantiates one role in practice: a narrow, read-only `plan` role for PR checks (`AWS_PLAN_ROLE_ARN`). There is no `apply` role — CI never applies anything; real deploys are `terraform apply` run manually from a human's machine (see `backlog/decisions/decision-5`).

## 런타임 불변식 (precondition/postcondition)

`aws_iam_role.this`에 `precondition`을 달아, `allowed_ref`가 `"*"`이거나 `refs/`로 시작하는 실제 git ref인지 검증한다 — `"main"`처럼 브랜치 이름만 넣는 실수를 막는다(GitHub OIDC의 실제 `sub` 클레임은 항상 `refs/heads/main` 형태라 브랜치 이름만으론 절대 매치되지 않는다).

## 공식문서

- [IAM: OIDC 자격증명 공급자 생성](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_providers_create_oidc.html)
- [GitHub Actions: AWS용 OpenID Connect 구성](https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/configuring-openid-connect-in-amazon-web-services)
- Terraform: [`aws_iam_openid_connect_provider`](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_openid_connect_provider)

<!-- BEGIN_TF_DOCS -->
## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_allowed_ref"></a> [allowed\_ref](#input\_allowed\_ref) | Git ref allowed to assume this role, e.g. refs/heads/main. Use "*" to allow any branch/PR (not recommended for a role with write access). | `string` | `"refs/heads/main"` | no |
| <a name="input_create_oidc_provider"></a> [create\_oidc\_provider](#input\_create\_oidc\_provider) | Whether to create the GitHub OIDC provider. Set to false if it already exists in this account (an AWS account can only have one). | `bool` | `true` | no |
| <a name="input_github_org"></a> [github\_org](#input\_github\_org) | GitHub organization or user that owns the repo allowed to assume this role | `string` | n/a | yes |
| <a name="input_github_repo"></a> [github\_repo](#input\_github\_repo) | Repository name (without org prefix) allowed to assume this role | `string` | n/a | yes |
| <a name="input_policy_arns"></a> [policy\_arns](#input\_policy\_arns) | List of managed policy ARNs to attach to the role | `list(string)` | `[]` | no |
| <a name="input_role_name"></a> [role\_name](#input\_role\_name) | Name of the IAM role GitHub Actions will assume | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags applied to the role | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_oidc_provider_arn"></a> [oidc\_provider\_arn](#output\_oidc\_provider\_arn) | ARN of the GitHub OIDC provider used |
| <a name="output_role_arn"></a> [role\_arn](#output\_role\_arn) | ARN of the IAM role GitHub Actions assumes via OIDC |
<!-- END_TF_DOCS -->
