output "domain_name" {
  description = "CloudFront's assigned domain name (e.g. dxxxx.cloudfront.net) -- point a Route53 alias record at this, or use it directly."
  value       = aws_cloudfront_distribution.this.domain_name
}

output "distribution_id" {
  description = "Distribution ID -- needed for cache invalidations and referencing this distribution elsewhere."
  value       = aws_cloudfront_distribution.this.id
}

output "distribution_arn" {
  description = "Distribution ARN -- reference this from the origin S3 bucket's policy to allow this distribution to read it via OAC."
  value       = aws_cloudfront_distribution.this.arn
}
