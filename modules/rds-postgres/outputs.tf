output "endpoint" {
  description = "Connection endpoint (host:port)"
  value       = aws_db_instance.this.endpoint
}

output "db_instance_id" {
  value = aws_db_instance.this.id
}

output "arn" {
  value = aws_db_instance.this.arn
}

output "master_user_secret_arn" {
  description = "ARN of the Secrets Manager secret holding the master password"
  value       = aws_db_instance.this.master_user_secret[0].secret_arn
}

output "security_group_id" {
  value = aws_security_group.this.id
}
