output "backup_vault_name" {
  description = "Name of the AWS Backup vault holding recovery points for the RDS instance."
  value       = module.backup.vault_name
}

output "backup_plan_id" {
  description = "ID of the AWS Backup plan governing this scenario's backup schedule/retention."
  value       = module.backup.plan_id
}
