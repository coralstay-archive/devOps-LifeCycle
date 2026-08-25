# sns-sqs

One SNS topic fanning out to one SQS queue (the default AWS "message queue" pattern — see the root README's note on MQ vs SNS/SQS). Add more `aws_sns_topic_subscription` resources alongside this module to fan out to additional queues for `pub-sub-fanout`.

## Status

Implemented (minimal). No dead-letter queue yet — add `aws_sqs_queue` with `redrive_policy` when a scenario needs retry handling.

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
