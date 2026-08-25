output "artifacts_bucket_id" {
  value = module.artifacts_bucket.bucket_id
}

output "state_machine_arn" {
  value = module.orchestration.state_machine_arn
}
