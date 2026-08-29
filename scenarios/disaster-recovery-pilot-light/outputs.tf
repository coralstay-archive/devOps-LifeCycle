output "rds_endpoint" {
  description = "Connection endpoint for the pilot-light standby RDS instance (deliberately undersized -- see instance_class override in main.tf)."
  value       = module.rds.endpoint
}

output "backup_vault_name" {
  description = "Name of the AWS Backup vault holding recovery points for the standby RDS instance."
  value       = module.backup.vault_name
}
