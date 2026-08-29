# backup-restore-baseline

**카테고리**: 가용성/재해복구
**설명**: AWS Backup 기반 정기 백업/복구 정책 baseline.

## 상태

composed — `vpc`+`rds-postgres`+`aws-backup`(RDS를 매일 백업, 35일 보관 기본값) 조합, `terraform validate` 통과. `disaster-recovery-pilot-light`와 리소스 구성은 겹치지만 목적이 다르다 — 여긴 "백업 정책 자체"가 핵심이고, 그쪽은 "페일오버 준비 상태"가 핵심.

## 관련 모듈

vpc, rds-postgres, aws-backup

## 참고자료

- [AWS Backup 개발자 안내서](https://docs.aws.amazon.com/aws-backup/latest/devguide/whatisbackup.html)
- 관련 모듈 문서: `vpc`, `rds-postgres`, `aws-backup`

<!-- BEGIN_TF_DOCS -->
## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones) | Availability zones for the vpc module to spread subnets across (multi-AZ by default). | `list(string)` | <pre>[<br/>  "ap-northeast-2a",<br/>  "ap-northeast-2c"<br/>]</pre> | no |
| <a name="input_name"></a> [name](#input\_name) | Name prefix passed through to every module this scenario composes (vpc, rds-postgres, aws-backup). | `string` | `"backup-restore-baseline"` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_backup_plan_id"></a> [backup\_plan\_id](#output\_backup\_plan\_id) | ID of the AWS Backup plan governing this scenario's backup schedule/retention. |
| <a name="output_backup_vault_name"></a> [backup\_vault\_name](#output\_backup\_vault\_name) | Name of the AWS Backup vault holding recovery points for the RDS instance. |
<!-- END_TF_DOCS -->