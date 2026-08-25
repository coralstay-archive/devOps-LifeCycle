output "state_machine_arn" {
  value = module.orchestration.state_machine_arn
}

output "glue_database_name" {
  value = module.glue.database_name
}
