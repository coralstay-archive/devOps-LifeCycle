data "archive_file" "lambda" {
  type        = "zip"
  source_file = "${path.module}/src/handler.py"
  output_path = "${path.module}/build/handler.zip"
}

module "messaging" {
  source = "../../modules/sns-sqs"
  name   = var.name
}

module "consumer" {
  source = "../../modules/lambda"

  function_name = var.name
  filename      = data.archive_file.lambda.output_path
  handler       = "handler.handler"
}

resource "aws_iam_role_policy" "sqs_access" {
  name = "${var.name}-sqs-access"
  role = module.consumer.role_name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect   = "Allow"
      Action   = ["sqs:ReceiveMessage", "sqs:DeleteMessage", "sqs:GetQueueAttributes"]
      Resource = module.messaging.queue_arn
    }]
  })
}

resource "aws_lambda_event_source_mapping" "sqs" {
  event_source_arn = module.messaging.queue_arn
  function_name    = module.consumer.function_name
  batch_size       = 5
}
