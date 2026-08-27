# Bucket names must be globally unique across all of AWS, not just this
# account — appending the account ID is a cheap way to get a name that won't
# collide with someone else's bucket without the caller having to think
# about it.
data "aws_caller_identity" "current" {}

module "site_bucket" {
  source      = "../../modules/s3-bucket"
  bucket_name = "${var.name}-${data.aws_caller_identity.current.account_id}"
}

# bucket_regional_domain_name (not a plain bucket name/website endpoint) is
# specifically what CloudFront's S3 origin wants — it's the private,
# non-website-hosting-enabled way to point at the bucket, which is what lets
# OAC (below) mediate access instead of the bucket needing to be public.
module "cdn" {
  source = "../../modules/cloudfront"

  name               = var.name
  origin_domain_name = module.site_bucket.bucket_regional_domain_name
}

# This is the other half of OAC: the cloudfront module configures the
# distribution to sign requests, but S3 also has to be told to trust
# requests signed by *this specific distribution* (via the SourceArn
# condition) — without this policy, CloudFront's signed requests would still
# get denied by the bucket.
resource "aws_s3_bucket_policy" "cloudfront_read" {
  bucket = module.site_bucket.bucket_id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = { Service = "cloudfront.amazonaws.com" }
      Action    = "s3:GetObject"
      Resource  = "${module.site_bucket.bucket_arn}/*"
      Condition = {
        StringEquals = { "AWS:SourceArn" = module.cdn.distribution_arn }
      }
    }]
  })
}
