output "replication_task_arn" {
  description = "ARN of the DMS full-load-and-CDC replication task moving changes from the source DB to the target Kafka cluster."
  value       = module.dms.replication_task_arn
}
