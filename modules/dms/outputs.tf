output "replication_instance_arn" {
  description = "ARN of the DMS replication instance."
  value       = aws_dms_replication_instance.this.replication_instance_arn
}

output "replication_task_arn" {
  description = "ARN of the DMS replication task."
  value       = aws_dms_replication_task.this.replication_task_arn
}
