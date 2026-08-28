output "secret_arn" {
  description = "ARN of the secret container (independent of whether a value has been set via secret_string)."
  value       = aws_secretsmanager_secret.this.arn
}

output "secret_id" {
  description = "ID of the secret container, usable in IAM policies or as a lookup key for aws_secretsmanager_secret_version data sources."
  value       = aws_secretsmanager_secret.this.id
}
