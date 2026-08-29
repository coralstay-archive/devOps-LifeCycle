# cdc-pipeline

**카테고리**: 데이터/스트리밍
**설명**: DMS+Kafka로 데이터베이스 변경분을 캡처해 스트리밍.

## 상태

composed — `vpc`+`rds-postgres`(source)+`msk-kafka`(target)+`dms` 조합, `terraform validate` 통과.

**의도적 설계**: `rds-postgres`의 마스터 비밀번호는 Secrets Manager가 관리해 평문으로 노출되지 않는다. DMS는 literal 자격증명이 필요하므로, 마스터 계정을 재사용하지 않고 `dms_reader`라는 별도 읽기 전용 계정을 쓴다고 가정했다 — 그 계정의 비밀번호가 `source_db_password` 변수다. 실제로는 이 계정을 DB에 별도로 생성해줘야 한다(이 모듈 조합만으로는 생성되지 않음).

## 관련 모듈

vpc, rds-postgres, msk-kafka, dms

## 참고자료

- [AWS DMS 모범 사례 (CDC 포함)](https://docs.aws.amazon.com/dms/latest/userguide/CHAP_BestPractices.html)
- 관련 모듈 문서: `vpc`, `rds-postgres`, `msk-kafka`, `dms`

<!-- BEGIN_TF_DOCS -->
## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones) | Availability zones for the vpc module to spread subnets across (multi-AZ by default). | `list(string)` | <pre>[<br/>  "ap-northeast-2a",<br/>  "ap-northeast-2c"<br/>]</pre> | no |
| <a name="input_name"></a> [name](#input\_name) | Name prefix passed through to every module this scenario composes (vpc, rds-postgres, msk-kafka, dms). | `string` | `"cdc-pipeline"` | no |
| <a name="input_source_db_password"></a> [source\_db\_password](#input\_source\_db\_password) | Password for a dedicated DMS read user on the source DB (not the RDS master password, which is Secrets-Manager-managed and not exposed as plaintext) | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_replication_task_arn"></a> [replication\_task\_arn](#output\_replication\_task\_arn) | ARN of the DMS full-load-and-CDC replication task moving changes from the source DB to the target Kafka cluster. |
<!-- END_TF_DOCS -->