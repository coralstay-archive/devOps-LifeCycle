output "artifacts_bucket_id" {
  description = "S3 bucket holding training artifacts (model outputs, checkpoints)."
  value       = module.artifacts_bucket.bucket_id
}

output "state_machine_arn" {
  description = "Step Functions state machine ARN that orchestrates the training pipeline -- use to trigger/monitor runs."
  value       = module.orchestration.state_machine_arn
}
