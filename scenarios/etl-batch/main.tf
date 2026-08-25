data "aws_caller_identity" "current" {}

module "bucket" {
  source      = "../../modules/s3-bucket"
  bucket_name = "${var.name}-${data.aws_caller_identity.current.account_id}"
}

module "glue" {
  source = "../../modules/glue"

  database_name  = replace(var.name, "-", "_")
  s3_target_path = "s3://${module.bucket.bucket_id}/raw/"
}

module "orchestration" {
  source = "../../modules/step-functions"
  name   = var.name
}
