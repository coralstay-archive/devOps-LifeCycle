# A workgroup isolates query execution/billing/settings — enforce_
# workgroup_configuration = true means every query using this workgroup uses
# these settings (like output_location) regardless of what the query client
# tries to override, which matters for cost/governance control.
resource "aws_athena_workgroup" "this" {
  name = var.name

  configuration {
    enforce_workgroup_configuration = true

    result_configuration {
      output_location = var.output_location
    }
  }

  tags = var.tags

  # Athena writes query results as objects in S3 — a non-S3 output location
  # isn't just unconventional, it's not something Athena supports at all.
  lifecycle {
    precondition {
      condition     = startswith(var.output_location, "s3://")
      error_message = "output_location must be an s3:// URI."
    }
  }
}
