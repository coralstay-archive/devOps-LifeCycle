output "alarm_topic_arn" {
  description = "SNS topic ARN that all CloudWatch alarms publish to."
  value       = module.observability.alarm_topic_arn
}

output "dashboard_name" {
  description = "Name of the CloudWatch dashboard created for this baseline."
  value       = module.observability.dashboard_name
}
