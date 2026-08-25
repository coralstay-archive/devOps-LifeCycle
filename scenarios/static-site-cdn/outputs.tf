output "cloudfront_domain_name" {
  value = module.cdn.domain_name
}

output "bucket_id" {
  value = module.site_bucket.bucket_id
}
