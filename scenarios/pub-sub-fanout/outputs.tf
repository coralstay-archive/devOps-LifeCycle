output "topic_arn" {
  description = "SNS topic ARN publishers send to -- fans out to every queue in queue_names."
  value       = aws_sns_topic.this.arn
}

output "queue_urls" {
  description = "Map of queue_names entry to its SQS queue URL, one per subscriber."
  value       = { for k, q in aws_sqs_queue.this : k => q.id }
}
