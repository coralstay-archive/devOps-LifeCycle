# Zips the handler at plan time instead of requiring a pre-built artifact —
# lambda's `filename` input needs an actual zip to exist on disk, and this
# is how that gets produced without a separate build step.
data "archive_file" "lambda" {
  type        = "zip"
  source_file = "${path.module}/src/handler.py"
  output_path = "${path.module}/build/handler.zip"
}

# No dependency on anything else — DynamoDB doesn't need a VPC to exist
# (it's a fully managed, non-VPC service, unlike RDS).
module "dynamodb" {
  source     = "../../modules/dynamodb"
  table_name = var.name
}

# filename comes from the archive_file data source above, not a literal path
# — this is the connection that makes "edit handler.py, terraform apply"
# actually redeploy the new code (source_code_hash changes when the zip's
# contents change).
module "lambda" {
  source = "../../modules/lambda"

  function_name = var.name
  filename      = data.archive_file.lambda.output_path
  handler       = "handler.handler"

  environment_variables = {
    TABLE_NAME = module.dynamodb.table_name
  }
}

# The lambda module only grants basic CloudWatch Logs permissions — this is
# the extra grant letting the function actually read/write the table whose
# name it was just handed above. role_name (not role_arn) because
# aws_iam_role_policy's `role` argument wants a role name/ID, not an ARN.
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

# invoke_arn (not function_arn) specifically — API Gateway's integration_uri
# needs the invoke-flavored ARN format, which is a different string than the
# plain function ARN used elsewhere (e.g. in IAM policies).
module "api_gateway" {
  source = "../../modules/api-gateway"

  name                 = var.name
  lambda_invoke_arn    = module.lambda.invoke_arn
  lambda_function_name = module.lambda.function_name
}
