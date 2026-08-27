# ecr

Container image repository: scan-on-push, immutable tags (prevents accidentally overwriting a deployed tag), untagged images expire after 14 days by default.

## Status

Implemented (minimal).

## 런타임 불변식 (precondition/postcondition)

`aws_ecr_repository.this`에 `precondition`을 달아, `untagged_image_expiry_days`가 1 이상인지 검증한다.

## 공식문서

- [Amazon ECR 사용 설명서](https://docs.aws.amazon.com/AmazonECR/latest/userguide/what-is-ecr.html)
- Terraform: [`aws_ecr_repository`](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository)

<!-- BEGIN_TF_DOCS -->
## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_name"></a> [name](#input\_name) | Repository name | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | `{}` | no |
| <a name="input_untagged_image_expiry_days"></a> [untagged\_image\_expiry\_days](#input\_untagged\_image\_expiry\_days) | n/a | `number` | `14` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_repository_arn"></a> [repository\_arn](#output\_repository\_arn) | n/a |
| <a name="output_repository_url"></a> [repository\_url](#output\_repository\_url) | n/a |
<!-- END_TF_DOCS -->
