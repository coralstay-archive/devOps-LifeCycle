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

resource "aws_iam_role_policy_attachment" "basic_execution" {
  role       = aws_iam_role.this.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_cloudwatch_log_group" "this" {
  name              = "/aws/lambda/${var.function_name}"
  retention_in_days = var.log_retention_days
  tags              = var.tags
}

resource "aws_lambda_function" "this" {
  function_name    = var.function_name
  filename         = var.filename
  source_code_hash = filebase64sha256(var.filename)
  handler          = var.handler
  runtime          = var.runtime
  role             = aws_iam_role.this.arn
  memory_size      = var.memory_size
  timeout          = var.timeout

  environment {
    variables = var.environment_variables
  }

  tags = var.tags

  depends_on = [aws_cloudwatch_log_group.this]
}
