# sns-sqs

One SNS topic fanning out to one SQS queue (the default AWS "message queue" pattern — see the root README's note on MQ vs SNS/SQS). Add more `aws_sns_topic_subscription` resources alongside this module to fan out to additional queues for `pub-sub-fanout`.

## Status

Implemented (minimal). No dead-letter queue yet — add `aws_sqs_queue` with `redrive_policy` when a scenario needs retry handling.

## Not yet included

**Customer-managed KMS key** — both the topic and queue use the AWS-managed `alias/aws/sns` / `alias/aws/sqs` keys (encryption at rest is always on; this is about who manages the key). Add a `kms_key_arn` variable if a scenario needs key rotation control/audit.

## 런타임 불변식 (precondition/postcondition)

`aws_sqs_queue.this`에 `postcondition`을 달아, 생성된 ARN이 올바른 SQS ARN 형태인지 검증한다.

## 공식문서

- [Amazon SNS 개발자 안내서](https://docs.aws.amazon.com/sns/latest/dg/welcome.html)
- [Amazon SQS 개발자 안내서](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/welcome.html)
- Terraform: [`aws_sns_topic`](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic), [`aws_sqs_queue`](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue)

<!-- BEGIN_TF_DOCS -->
## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_queue_arn"></a> [queue\_arn](#output\_queue\_arn) | n/a |
| <a name="output_queue_url"></a> [queue\_url](#output\_queue\_url) | n/a |
| <a name="output_topic_arn"></a> [topic\_arn](#output\_topic\_arn) | n/a |
<!-- END_TF_DOCS -->
