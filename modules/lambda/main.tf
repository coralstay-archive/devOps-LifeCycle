# The role Lambda assumes to run the function — separate from what the
# function is allowed to do, which is handled below by the basic-execution
# policy attachment.
resource "aws_iam_role" "this" {
  name = "${var.function_name}-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = { Service = "lambda.amazonaws.com" }
      Action    = "sts:AssumeRole"
    }]
  })

  tags = var.tags
}

# Minimum viable permission: write logs to CloudWatch. Anything beyond that
# (DynamoDB access, S3, etc.) is workload-specific and deliberately not
# baked into this generic module.
resource "aws_iam_role_policy_attachment" "basic_execution" {
  role       = aws_iam_role.this.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# Required for tracing_config below to actually write anything to X-Ray —
# without this permission, Active tracing silently produces no traces.
resource "aws_iam_role_policy_attachment" "xray" {
  role       = aws_iam_role.this.name
  policy_arn = "arn:aws:iam::aws:policy/AWSXRayDaemonWriteAccess"
}

# Declared explicitly (with a real retention period) instead of letting
# Lambda auto-create it — Lambda's auto-created log group defaults to never
# expiring, which quietly accumulates cost forever.
resource "aws_cloudwatch_log_group" "this" {
  name              = "/aws/lambda/${var.function_name}"
  retention_in_days = var.log_retention_days
  tags              = var.tags
}

resource "aws_lambda_function" "this" {
  function_name = var.function_name
  filename      = var.filename
  # Forces Terraform to detect code changes: without a source_code_hash tied
  # to the actual zip contents, Terraform has no way to know the deployment
  # package changed and would skip updating the function.
  source_code_hash = filebase64sha256(var.filename)
  handler          = var.handler
  runtime          = var.runtime
  role             = aws_iam_role.this.arn
  memory_size      = var.memory_size
  timeout          = var.timeout

  environment {
    variables = var.environment_variables
  }

  # Free observability win: samples and records request traces with no
  # code changes needed, as long as the xray policy attachment above exists.
  tracing_config {
    mode = "Active"
  }

  tags = var.tags

  # 128-10240 MB is Lambda's actual valid range, not a value this module
  # invented — outside it the API rejects the function outright.
  lifecycle {
    precondition {
      condition     = var.memory_size >= 128 && var.memory_size <= 10240
      error_message = "memory_size must be between 128 and 10240 MB — this is a Lambda API requirement, not just a style preference."
    }
  }

  # Explicit dependency: the log group should exist before the function
  # starts writing to it, even though nothing in the function's own
  # arguments references the log group to make that ordering implicit.
  depends_on = [aws_cloudwatch_log_group.this]
}
