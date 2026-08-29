output "topic_arn" {
  description = "SNS topic ARN producers publish events to."
  value       = module.messaging.topic_arn
}

output "consumer_function_name" {
  description = "Name of the Lambda function consuming events off the topic's subscribed queue."
  value       = module.consumer.function_name
}
