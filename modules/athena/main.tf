resource "aws_athena_workgroup" "this" {
  name = var.name

  configuration {
    enforce_workgroup_configuration = true

    result_configuration {
      output_location = var.output_location
    }
  }

  tags = var.tags
}
