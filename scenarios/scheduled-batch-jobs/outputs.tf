output "function_name" {
  description = "Name of the Lambda function running the scheduled job."
  value       = module.job.function_name
}

output "rule_arn" {
  description = "ARN of the EventBridge rule that triggers the job on schedule_expression."
  value       = module.schedule.rule_arn
}
