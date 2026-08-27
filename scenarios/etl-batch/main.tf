data "aws_caller_identity" "current" {}

module "bucket" {
  source      = "../../modules/s3-bucket"
  bucket_name = "${var.name}-${data.aws_caller_identity.current.account_id}"
}

# Same bucket-output-into-crawler-path wiring as data-lake.
module "glue" {
  source = "../../modules/glue"

  database_name  = replace(var.name, "-", "_")
  s3_target_path = "s3://${module.bucket.bucket_id}/raw/"
}

# Not actually wired to glue yet — this is the step-functions module's
# default placeholder definition (a single Pass state), not a real ETL
# workflow. Connecting it for real means writing an ASL definition that
# calls glue's crawler (by name/ARN, from the glue module's outputs above)
# and granting this state machine's role permission to do so.
module "orchestration" {
  source = "../../modules/step-functions"
  name   = var.name
}
