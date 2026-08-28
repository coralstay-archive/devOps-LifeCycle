# glue

Catalog database + one crawler pointed at an S3 path (on-demand by default; set `crawler_schedule` for periodic re-crawls). Uses the broad `AmazonS3ReadOnlyAccess` managed policy for simplicity — scope it to the specific bucket in anything handling sensitive data.

## Status

Implemented (minimal). ETL jobs (`aws_glue_job`) not included — add when `etl-batch` needs actual transform logic, not just cataloging.

## Not yet included

**Security configuration is now attached, but encryption is opt-in** — `aws_glue_security_configuration` is now always created and wired into the crawler, but all three modes (CloudWatch logs, job bookmarks, S3) default to `DISABLED` (Glue's own default) unless `kms_key_arn` is set. Pass a CMK once a scenario needs encrypted Glue job artifacts.

## 런타임 불변식 (precondition/postcondition)

`aws_glue_catalog_database.this`에 `precondition`을 달아, `database_name`이 소문자/숫자/언더스코어만 쓰는지 검증한다 — Glue 카탈로그 네이밍 규칙(하이픈 불가).

## 공식문서

- [AWS Glue 개발자 안내서](https://docs.aws.amazon.com/glue/latest/dg/what-is-glue.html)
- Terraform: [`aws_glue_crawler`](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/glue_crawler), [`aws_glue_catalog_database`](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/glue_catalog_database)

<!-- BEGIN_TF_DOCS -->
## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_crawler_schedule"></a> [crawler\_schedule](#input\_crawler\_schedule) | cron() expression. Leave null to run on-demand only. | `string` | `null` | no |
| <a name="input_database_name"></a> [database\_name](#input\_database\_name) | Name of the Glue catalog database. Lowercase alphanumeric/underscore only -- Glue's naming rule doesn't allow hyphens, unlike most AWS resource names. | `string` | n/a | yes |
| <a name="input_kms_key_arn"></a> [kms\_key\_arn](#input\_kms\_key\_arn) | Customer-managed KMS key for the crawler's security configuration (CloudWatch logs, job bookmarks, S3 reads). Leave null to leave all three encryption modes DISABLED (Glue's own default). | `string` | `null` | no |
| <a name="input_s3_target_path"></a> [s3\_target\_path](#input\_s3\_target\_path) | e.g. s3://my-bucket/raw/ | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags applied to the crawler and its IAM role. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_crawler_name"></a> [crawler\_name](#output\_crawler\_name) | Name of the Glue crawler. |
| <a name="output_database_name"></a> [database\_name](#output\_database\_name) | Name of the Glue catalog database. |
<!-- END_TF_DOCS -->
