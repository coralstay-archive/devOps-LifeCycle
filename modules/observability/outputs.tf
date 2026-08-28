output "alarm_topic_arn" {
  description = "ARN of the shared SNS topic every alarm notifies -- subscribe additional endpoints (Slack, PagerDuty) to it directly"
  value       = aws_sns_topic.alarms.arn
}

output "dashboard_name" {
  description = "Name of the created CloudWatch dashboard"
  value       = aws_cloudwatch_dashboard.this.dashboard_name
}
