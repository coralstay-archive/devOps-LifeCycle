output "endpoint" {
  value = aws_redshift_cluster.this.endpoint
}

output "cluster_id" {
  value = aws_redshift_cluster.this.id
}

# manage_master_password = true already makes AWS generate and store this
# secret — it just wasn't exposed here before, so there was no way for a
# caller to actually retrieve the password (same pattern as
# rds-postgres.master_user_secret_arn).
output "master_password_secret_arn" {
  description = "ARN of the Secrets Manager secret holding the master password"
  value       = aws_redshift_cluster.this.master_password_secret_arn
}
