output "state_bucket_name" {
  description = "Name of the versioned S3 bucket to reference in each live/<project> stack's backend \"s3\" block."
  value       = module.state_bucket.bucket_id
}
