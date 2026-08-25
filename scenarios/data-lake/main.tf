data "aws_caller_identity" "current" {}

module "lake_bucket" {
  source      = "../../modules/s3-bucket"
  bucket_name = "${var.name}-${data.aws_caller_identity.current.account_id}"
}

module "glue" {
  source = "../../modules/glue"

  database_name  = replace(var.name, "-", "_")
  s3_target_path = "s3://${module.lake_bucket.bucket_id}/raw/"
}

module "athena" {
  source = "../../modules/athena"

  name            = var.name
  output_location = "s3://${module.lake_bucket.bucket_id}/athena-results/"
}
