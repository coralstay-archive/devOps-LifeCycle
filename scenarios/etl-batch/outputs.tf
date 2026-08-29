output "state_machine_arn" {
  description = "Step Functions state machine ARN that orchestrates the ETL job -- use to trigger/monitor runs."
  value       = module.orchestration.state_machine_arn
}

output "glue_database_name" {
  description = "Glue Data Catalog database name the crawler populates -- query it via Athena once crawled."
  value       = module.glue.database_name
}
