# s3-bucket

Baseline S3 bucket: versioning on, SSE-S3 encryption, all public access blocked.

## Status

Implemented (minimal). Used by `live/example-dev`.

## Inputs

See `variables.tf`. Key ones: `bucket_name`, `versioning_enabled`, `force_destroy`.

## Outputs

`bucket_id`, `bucket_arn`.

## Not yet included

Lifecycle rules, replication, access logging, KMS (currently SSE-S3/AES256, not SSE-KMS). Add when a scenario needs them.

## 런타임 불변식 (precondition/postcondition)

`bucket_arn` 출력에 `precondition`을 달아, 값이 항상 유효한 S3 ARN 형태(`arn:aws:s3:::`로 시작)인지 검증한다. (참고: `terraform test`의 mock_provider는 이 값을 가짜 문자열로 대체하므로, 테스트 파일에서 `override_resource`로 실제 ARN 형태 값을 지정해줘야 한다 — `tests/s3-bucket.tftest.hcl` 참고.)

## 공식문서

- [Amazon S3 사용 설명서](https://docs.aws.amazon.com/AmazonS3/latest/userguide/Welcome.html)
- Terraform: [`aws_s3_bucket`](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket), [`aws_s3_bucket_versioning`](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning), [`aws_s3_bucket_public_access_block`](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block)

<!-- BEGIN_TF_DOCS -->
## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | Globally unique S3 bucket name | `string` | n/a | yes |
| <a name="input_force_destroy"></a> [force\_destroy](#input\_force\_destroy) | Allow bucket deletion even if it still contains objects (keep false for anything holding real data) | `bool` | `false` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags applied to the bucket | `map(string)` | `{}` | no |
| <a name="input_versioning_enabled"></a> [versioning\_enabled](#input\_versioning\_enabled) | Enable object versioning (required for safe Terraform state buckets) | `bool` | `true` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_bucket_arn"></a> [bucket\_arn](#output\_bucket\_arn) | ARN of the created bucket |
| <a name="output_bucket_id"></a> [bucket\_id](#output\_bucket\_id) | Name of the created bucket |
| <a name="output_bucket_regional_domain_name"></a> [bucket\_regional\_domain\_name](#output\_bucket\_regional\_domain\_name) | Regional domain name, useful as a CloudFront origin |
<!-- END_TF_DOCS -->
