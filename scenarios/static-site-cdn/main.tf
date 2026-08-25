data "aws_caller_identity" "current" {}

module "site_bucket" {
  source      = "../../modules/s3-bucket"
  bucket_name = "${var.name}-${data.aws_caller_identity.current.account_id}"
}

module "cdn" {
  source = "../../modules/cloudfront"

  name               = var.name
  origin_domain_name = module.site_bucket.bucket_regional_domain_name
}

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
