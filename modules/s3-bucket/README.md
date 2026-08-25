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
