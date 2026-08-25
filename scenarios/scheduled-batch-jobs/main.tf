data "archive_file" "lambda" {
  type        = "zip"
  source_file = "${path.module}/src/handler.py"
  output_path = "${path.module}/build/handler.zip"
}

module "job" {
  source = "../../modules/lambda"

  function_name = var.name
  filename      = data.archive_file.lambda.output_path
  handler       = "handler.handler"
  timeout       = 60
}

module "schedule" {
  source = "../../modules/eventbridge"

  name                = var.name
  schedule_expression = var.schedule_expression
  target_arn          = module.job.function_arn
  target_is_lambda    = true
}
