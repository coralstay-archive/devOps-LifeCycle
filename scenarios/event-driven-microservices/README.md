# event-driven-microservices

**카테고리**: 이벤트/메시징
**설명**: SNS/SQS+Lambda 기반 이벤트 드리븐 마이크로서비스.

## 상태

composed — `sns-sqs`(토픽→큐)+`lambda`(SQS 이벤트 소스 매핑으로 컨슈밍) 조합, `terraform validate` 통과. `src/handler.py`에 최소 컨슈머 로직 포함.

## 관련 모듈

sns-sqs, lambda

## 참고자료

- 관련 모듈 문서: `sns-sqs`, `lambda`

<!-- BEGIN_TF_DOCS -->
## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_name"></a> [name](#input\_name) | Base name used as the prefix/tag for the SNS/SQS messaging resources and the consumer Lambda. | `string` | `"event-driven-microservices"` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_consumer_function_name"></a> [consumer\_function\_name](#output\_consumer\_function\_name) | Name of the Lambda function consuming events off the topic's subscribed queue. |
| <a name="output_topic_arn"></a> [topic\_arn](#output\_topic\_arn) | SNS topic ARN producers publish events to. |
<!-- END_TF_DOCS -->