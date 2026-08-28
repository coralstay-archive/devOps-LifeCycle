# eventbridge

One rule (schedule or event pattern — pick one) + one target. Set `target_is_lambda = true` when targeting a Lambda function so it gets the invoke permission automatically.

## Status

Implemented (minimal). Single target only — for fan-out to multiple targets, add more `aws_cloudwatch_event_target` resources.

## 런타임 불변식 (precondition/postcondition)

`aws_cloudwatch_event_rule.this`에 `precondition`을 달아, `schedule_expression`과 `event_pattern` 중 정확히 하나만 설정됐는지(XOR) 검증한다.

## 공식문서

- [Amazon EventBridge 사용 설명서](https://docs.aws.amazon.com/eventbridge/latest/userguide/eb-what-is.html)
- Terraform: [`aws_cloudwatch_event_rule`](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule)

<!-- BEGIN_TF_DOCS -->
## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_event_pattern"></a> [event\_pattern](#input\_event\_pattern) | JSON event pattern string. Mutually exclusive with schedule\_expression. | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the EventBridge rule. | `string` | n/a | yes |
| <a name="input_schedule_expression"></a> [schedule\_expression](#input\_schedule\_expression) | e.g. rate(5 minutes) or cron(...). Mutually exclusive with event\_pattern. | `string` | `null` | no |
| <a name="input_target_arn"></a> [target\_arn](#input\_target\_arn) | ARN the rule invokes when it fires (e.g. a Lambda function ARN, SQS queue ARN, or Step Functions state machine ARN). | `string` | n/a | yes |
| <a name="input_target_is_lambda"></a> [target\_is\_lambda](#input\_target\_is\_lambda) | Set true if target\_arn is a Lambda function, to attach the invoke permission | `bool` | `false` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_rule_arn"></a> [rule\_arn](#output\_rule\_arn) | ARN of the EventBridge rule. |
<!-- END_TF_DOCS -->
