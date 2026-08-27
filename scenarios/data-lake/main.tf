data "aws_caller_identity" "current" {}

module "lake_bucket" {
  source      = "../../modules/s3-bucket"
  bucket_name = "${var.name}-${data.aws_caller_identity.current.account_id}"
}

# s3_target_path is built from the bucket module's own bucket_id output, not
# a hardcoded name — this is what makes the crawler actually point at the
# bucket this scenario just created, under a raw/ prefix so future
# additions (processed/, curated/ zones) don't get swept into the same
# catalog table.
module "glue" {
  source = "../../modules/glue"

  database_name  = replace(var.name, "-", "_")
  s3_target_path = "s3://${module.lake_bucket.bucket_id}/raw/"
}

# database_name has hyphens replaced with underscores here specifically
# because Glue's catalog naming rule (enforced by that module's own
# precondition) disallows hyphens — var.name itself stays hyphenated for
# consistency with every other scenario's naming.
module "athena" {
  source = "../../modules/athena"

  name            = var.name
  output_location = "s3://${module.lake_bucket.bucket_id}/athena-results/"
}
