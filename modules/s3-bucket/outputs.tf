output "bucket_id" {
  description = "Name of the created bucket"
  value       = aws_s3_bucket.this.id
}

output "bucket_arn" {
  description = "ARN of the created bucket"
  value       = aws_s3_bucket.this.arn

  precondition {
    condition     = startswith(aws_s3_bucket.this.arn, "arn:aws:s3:::")
    error_message = "bucket_arn must be a well-formed S3 ARN — something is wrong with the aws_s3_bucket resource."
  }
}

output "bucket_regional_domain_name" {
  description = "Regional domain name, useful as a CloudFront origin"
  value       = aws_s3_bucket.this.bucket_regional_domain_name
}
