output "topic_arn" {
  description = "ARN of the SNS topic -- the publish side producers send events to."
  value       = aws_sns_topic.this.arn
}

output "queue_arn" {
  description = "ARN of the SQS queue subscribed to the topic -- grant consumers sqs:ReceiveMessage/DeleteMessage on this."
  value       = aws_sqs_queue.this.arn
}

output "queue_url" {
  description = "URL of the SQS queue, used by SDK calls like ReceiveMessage/SendMessage (aws_sqs_queue.id is the queue URL, not an ARN, despite the resource attribute's name)."
  value       = aws_sqs_queue.this.id
}
