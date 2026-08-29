output "vpc_id" {
  description = "ID of the VPC proving the pipeline can actually provision networking end to end."
  value       = module.vpc.vpc_id
}

output "bucket_id" {
  description = "Name of the S3 bucket proving the pipeline can actually provision storage end to end."
  value       = module.bucket.bucket_id
}
