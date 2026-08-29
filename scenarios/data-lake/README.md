# data-lake

**카테고리**: 데이터/스트리밍
**설명**: S3+Glue+Athena로 구성하는 데이터 레이크.

## 상태

composed — `s3-bucket`+`glue`+`athena` 조합, `terraform validate` 통과. 버킷의 `raw/` 프리픽스를 크롤러가 스캔하고, `athena-results/` 프리픽스로 쿼리 결과가 나간다.

## 관련 모듈

s3-bucket, glue, athena

## 참고자료

- [AWS 백서: Storage Best Practices for Data and Analytics Applications — 데이터 레이크 기초](https://docs.aws.amazon.com/whitepapers/latest/building-data-lakes/data-lake-foundation.html)
- 관련 모듈 문서: `s3-bucket`, `glue`, `athena`

<!-- BEGIN_TF_DOCS -->
## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_name"></a> [name](#input\_name) | Name prefix passed through to every module this scenario composes (s3-bucket, glue, athena). | `string` | `"data-lake"` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_athena_workgroup_name"></a> [athena\_workgroup\_name](#output\_athena\_workgroup\_name) | Athena workgroup configured to write query results into the same bucket's athena-results/ prefix. |
| <a name="output_bucket_id"></a> [bucket\_id](#output\_bucket\_id) | S3 bucket holding the lake's raw/ zone and Athena query results. |
| <a name="output_glue_database_name"></a> [glue\_database\_name](#output\_glue\_database\_name) | Glue Catalog database the crawler populates from the bucket's raw/ prefix. |
<!-- END_TF_DOCS -->