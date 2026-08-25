data "aws_caller_identity" "current" {}

module "artifacts_bucket" {
  source      = "../../modules/s3-bucket"
  bucket_name = "${var.name}-${data.aws_caller_identity.current.account_id}"
}

module "orchestration" {
  source = "../../modules/step-functions"
  name   = var.name
}
