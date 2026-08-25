output "broker_id" {
  value = aws_mq_broker.this.id
}

output "endpoints" {
  value = aws_mq_broker.this.instances[*].endpoints
}
