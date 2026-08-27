data "aws_caller_identity" "current" {}

# Where trained model artifacts land — referenced by name/path convention
# from whatever actually runs the training job (SDK or the orchestration
# state machine below), not by a direct Terraform output wiring since no
# training job resource exists here to wire it to.
module "artifacts_bucket" {
  source      = "../../modules/s3-bucket"
  bucket_name = "${var.name}-${data.aws_caller_identity.current.account_id}"
}

# Placeholder orchestration shell — see this module's default definition
# (a single Pass state) and the sagemaker module's README for why an actual
# SageMaker training job isn't a Terraform resource here at all.
module "orchestration" {
  source = "../../modules/step-functions"
  name   = var.name
}
