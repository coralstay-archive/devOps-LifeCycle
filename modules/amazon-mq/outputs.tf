output "broker_id" {
  description = "Broker ID."
  value       = aws_mq_broker.this.id
}

output "endpoints" {
  description = "Connection endpoints for each broker instance (a single instance, since this module always deploys SINGLE_INSTANCE)."
  value       = aws_mq_broker.this.instances[*].endpoints
}
