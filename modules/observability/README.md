# observability

SNS alarm topic + a starter CloudWatch dashboard (one markdown widget pointing at the stack's `SLO.md`) + a generic `alarms` map you fill in per stack (e.g. ALB 5xx rate, RDS CPU).

## Status

Implemented (minimal): CloudWatch baseline only.

## Example alarm entry

```hcl
alarms = {
  alb_5xx = {
    metric_name         = "HTTPCode_Target_5XX_Count"
    namespace           = "AWS/ApplicationELB"
    statistic           = "Sum"
    period              = 60
    evaluation_periods  = 5
    threshold           = 10
    comparison_operator = "GreaterThanThreshold"
    dimensions          = { LoadBalancer = module.alb.arn_suffix }
  }
}
```

## Not yet included

Prometheus/Grafana (AMP/AMG) for EKS scenarios, error-budget-burn-rate composite alarms. Add when an EKS-based scenario needs them.

**Customer-managed KMS key for the SNS topic** — `kms_key_arn` variable (default `null`, falls back to the AWS-managed `alias/aws/sns` key). Encryption at rest is always on either way; this is about who manages the key.

## 런타임 불변식 (precondition/postcondition)

`aws_sns_topic.alarms`에 `postcondition`을 달아, 생성된 ARN이 올바른 SNS ARN 형태인지 검증한다.

## 공식문서

- [Amazon CloudWatch 사용 설명서](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/WhatIsCloudWatch.html)
- [Amazon Managed Service for Prometheus](https://docs.aws.amazon.com/prometheus/latest/userguide/what-is-Amazon-Managed-Service-Prometheus.html)
- Terraform: [`aws_cloudwatch_dashboard`](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_dashboard), [`aws_cloudwatch_metric_alarm`](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm)

<!-- BEGIN_TF_DOCS -->
## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_alarm_email"></a> [alarm\_email](#input\_alarm\_email) | Email to subscribe to the alarm SNS topic. Leave null to skip (wire Slack/PagerDuty separately). | `string` | `null` | no |
| <a name="input_alarms"></a> [alarms](#input\_alarms) | Map of CloudWatch alarms to create, keyed by a short name | <pre>map(object({<br/>    metric_name         = string<br/>    namespace           = string<br/>    statistic           = string<br/>    period              = number<br/>    evaluation_periods  = number<br/>    threshold           = number<br/>    comparison_operator = string<br/>    dimensions          = map(string)<br/>  }))</pre> | `{}` | no |
| <a name="input_kms_key_arn"></a> [kms\_key\_arn](#input\_kms\_key\_arn) | Customer-managed KMS key ARN for the alarms SNS topic. Leave null to use the AWS-managed alias/aws/sns key. | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | Name prefix for the alarm SNS topic and dashboard | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags applied to the alarms SNS topic and CloudWatch alarms | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_alarm_topic_arn"></a> [alarm\_topic\_arn](#output\_alarm\_topic\_arn) | ARN of the shared SNS topic every alarm notifies -- subscribe additional endpoints (Slack, PagerDuty) to it directly |
| <a name="output_dashboard_name"></a> [dashboard\_name](#output\_dashboard\_name) | Name of the created CloudWatch dashboard |
<!-- END_TF_DOCS -->
