# disaster-recovery-pilot-light

**카테고리**: 가용성/재해복구
**설명**: 평소엔 최소 리소스만 유지하다 재해 시 확장하는 파일럿 라이트 DR.

## 상태

composed — `vpc`+`rds-postgres`(최소 인스턴스 크기)+`s3-bucket`(DR 산출물)+`aws-backup`(RDS 백업) 조합, `terraform validate` 통과. 실제 페일오버 자동화(리전 전환, DNS 스위치)는 포함하지 않음 — 이건 `multi-region-active-active`처럼 별도 리전 스택 + Route53 헬스체크/페일오버 레코드가 필요.

## 관련 모듈

vpc, rds-postgres, s3-bucket, aws-backup

## 참고자료

- [AWS 백서: Disaster Recovery of Workloads on AWS — 클라우드에서의 DR 옵션](https://docs.aws.amazon.com/whitepapers/latest/disaster-recovery-workloads-on-aws/disaster-recovery-options-in-the-cloud.html)
- 관련 모듈 문서: `vpc`, `rds-postgres`, `s3-bucket`, `aws-backup`

<!-- BEGIN_TF_DOCS -->
## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones) | n/a | `list(string)` | <pre>[<br/>  "ap-northeast-2a",<br/>  "ap-northeast-2c"<br/>]</pre> | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"disaster-recovery-pilot-light"` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_backup_vault_name"></a> [backup\_vault\_name](#output\_backup\_vault\_name) | n/a |
| <a name="output_rds_endpoint"></a> [rds\_endpoint](#output\_rds\_endpoint) | n/a |
<!-- END_TF_DOCS -->