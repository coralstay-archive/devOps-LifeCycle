resource "aws_athena_workgroup" "this" {
  name = var.name

  configuration {
    enforce_workgroup_configuration = true

    result_configuration {
      output_location = var.output_location
    }
  }

  tags = var.tags

  lifecycle {
    precondition {
      condition     = startswith(var.output_location, "s3://")
      error_message = "output_location must be an s3:// URI."
    }
  }
}
