output "cloudfront_domain_name" {
  description = "CloudFront distribution's domain name -- what visitors actually hit."
  value       = module.cdn.domain_name
}

output "bucket_id" {
  description = "Name of the S3 bucket holding the site's static assets, origin for the CloudFront distribution."
  value       = module.site_bucket.bucket_id
}
