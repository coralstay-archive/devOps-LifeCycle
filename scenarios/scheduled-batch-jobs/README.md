# scheduled-batch-jobs

**카테고리**: 이벤트/메시징
**설명**: EventBridge+ECS/Batch로 스케줄된 배치 작업 실행.

## 상태

composed — `lambda`+`eventbridge`(기본 1시간 주기) 조합, `terraform validate` 통과. ECS/Batch 대신 Lambda로 구현했다 — 작업이 15분(Lambda 최대 실행시간)을 넘기거나 컨테이너가 필요하면 `ecs-service`를 EventBridge 타겟으로 바꿀 것.

## 관련 모듈

lambda, eventbridge

## 참고자료

- 관련 모듈 문서: `lambda`, `eventbridge`

<!-- BEGIN_TF_DOCS -->
## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"scheduled-batch-jobs"` | no |
| <a name="input_schedule_expression"></a> [schedule\_expression](#input\_schedule\_expression) | n/a | `string` | `"rate(1 hour)"` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_function_name"></a> [function\_name](#output\_function\_name) | n/a |
| <a name="output_rule_arn"></a> [rule\_arn](#output\_rule\_arn) | n/a |
<!-- END_TF_DOCS -->