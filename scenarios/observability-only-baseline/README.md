# observability-only-baseline

**카테고리**: 운영/비용
**설명**: 다른 리소스 없이 관측성 스택만 독립적으로 배포해 검증하는 시나리오.

## 상태

composed — `observability` 모듈만 노출. `terraform validate` 통과. 다른 스택에 관측성을 어떻게 붙이는지 검증해보는 용도, 또는 알람 토픽/대시보드를 먼저 만들어두고 나중에 실제 리소스의 알람을 여기 연결하는 용도로 쓸 수 있다.

## 관련 모듈

observability

## 참고자료

- 관련 모듈 문서: `observability`

<!-- BEGIN_TF_DOCS -->
## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_alarm_email"></a> [alarm\_email](#input\_alarm\_email) | Email address to subscribe to the alarm SNS topic. Null skips the subscription -- the topic still exists, just with no email endpoint. | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | Name prefix applied to the observability module's alarms and dashboard. | `string` | `"observability-only-baseline"` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_alarm_topic_arn"></a> [alarm\_topic\_arn](#output\_alarm\_topic\_arn) | SNS topic ARN that all CloudWatch alarms publish to. |
| <a name="output_dashboard_name"></a> [dashboard\_name](#output\_dashboard\_name) | Name of the CloudWatch dashboard created for this baseline. |
<!-- END_TF_DOCS -->