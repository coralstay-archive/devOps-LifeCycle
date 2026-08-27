# athena

One workgroup pointed at an S3 results bucket. Query the tables a `glue` crawler catalogs.

## Status

Implemented (minimal).

## 런타임 불변식 (precondition/postcondition)

`aws_athena_workgroup.this`에 `precondition`을 달아, `output_location`이 `s3://`로 시작하는지 검증한다.

## 공식문서

- [Amazon Athena 사용 설명서](https://docs.aws.amazon.com/athena/latest/ug/what-is.html)
- Terraform: [`aws_athena_workgroup`](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/athena_workgroup)

<!-- BEGIN_TF_DOCS -->
## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | n/a | yes |
| <a name="input_output_location"></a> [output\_location](#input\_output\_location) | e.g. s3://my-bucket/athena-results/ | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_workgroup_name"></a> [workgroup\_name](#output\_workgroup\_name) | n/a |
<!-- END_TF_DOCS -->
