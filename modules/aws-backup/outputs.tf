output "vault_name" {
  description = "Backup vault name -- backups from the plan land here."
  value       = aws_backup_vault.this.name
}

output "plan_id" {
  description = "Backup plan ID."
  value       = aws_backup_plan.this.id
}
