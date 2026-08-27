output "bucket_id" {
  description = "Name of the created bucket"
  value       = aws_s3_bucket.this.id
}

output "bucket_arn" {
  description = "ARN of the created bucket"
  value       = aws_s3_bucket.this.arn

  # Cheap sanity check on the shape of a computed value. Not really about
  # catching AWS misbehaving — it's here mainly as the worked example other
  # modules copy for "does this output look like what callers will assume it
  # looks like" (e.g. static-site-cdn assumes bucket_arn is real to build a
  # CloudFront bucket policy from it).
  precondition {
    condition     = startswith(aws_s3_bucket.this.arn, "arn:aws:s3:::")
    error_message = "bucket_arn must be a well-formed S3 ARN — something is wrong with the aws_s3_bucket resource."
  }
}

output "bucket_regional_domain_name" {
  description = "Regional domain name, useful as a CloudFront origin"
  value       = aws_s3_bucket.this.bucket_regional_domain_name
}
