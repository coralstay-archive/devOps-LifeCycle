# sns-sqs

One SNS topic fanning out to one SQS queue (the default AWS "message queue" pattern — see the root README's note on MQ vs SNS/SQS). Add more `aws_sns_topic_subscription` resources alongside this module to fan out to additional queues for `pub-sub-fanout`.

## Status

Implemented (minimal). No dead-letter queue yet — add `aws_sqs_queue` with `redrive_policy` when a scenario needs retry handling.

## Not yet included

**Customer-managed KMS key** — `kms_key_arn` variable (default `null`, falls back to the AWS-managed `alias/aws/sns` / `alias/aws/sqs` keys for both the topic and queue). Encryption at rest is always on either way; this is about who manages the key.

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
| <a name="input_kms_key_arn"></a> [kms\_key\_arn](#input\_kms\_key\_arn) | Customer-managed KMS key ARN for both the topic and queue. Leave null to use the AWS-managed alias/aws/sns and alias/aws/sqs keys. | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | Base name for the SNS topic and SQS queue (suffixed with -topic/-queue). | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags applied to the topic and queue. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_queue_arn"></a> [queue\_arn](#output\_queue\_arn) | ARN of the SQS queue subscribed to the topic -- grant consumers sqs:ReceiveMessage/DeleteMessage on this. |
| <a name="output_queue_url"></a> [queue\_url](#output\_queue\_url) | URL of the SQS queue, used by SDK calls like ReceiveMessage/SendMessage (aws\_sqs\_queue.id is the queue URL, not an ARN, despite the resource attribute's name). |
| <a name="output_topic_arn"></a> [topic\_arn](#output\_topic\_arn) | ARN of the SNS topic -- the publish side producers send events to. |
<!-- END_TF_DOCS -->
