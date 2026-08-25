data "archive_file" "lambda" {
  type        = "zip"
  source_file = "${path.module}/src/handler.py"
  output_path = "${path.module}/build/handler.zip"
}

module "dynamodb" {
  source     = "../../modules/dynamodb"
  table_name = var.name
}

module "lambda" {
  source = "../../modules/lambda"

  function_name = var.name
  filename      = data.archive_file.lambda.output_path
  handler       = "handler.handler"

  environment_variables = {
    TABLE_NAME = module.dynamodb.table_name
  }
}

resource "aws_iam_role_policy" "dynamodb_access" {
  name = "${var.name}-dynamodb-access"
  role = module.lambda.role_name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect   = "Allow"
      Action   = ["dynamodb:GetItem", "dynamodb:PutItem", "dynamodb:Query"]
      Resource = module.dynamodb.table_arn
    }]
  })
}

module "api_gateway" {
  source = "../../modules/api-gateway"

  name                 = var.name
  lambda_invoke_arn    = module.lambda.invoke_arn
  lambda_function_name = module.lambda.function_name
}
