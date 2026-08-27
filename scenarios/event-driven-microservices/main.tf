data "archive_file" "lambda" {
  type        = "zip"
  source_file = "${path.module}/src/handler.py"
  output_path = "${path.module}/build/handler.zip"
}

# The topic->queue plumbing lives entirely inside this module — the
# scenario's job is just wiring the resulting queue to a consumer, below.
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

# lambda's basic-execution role only grants CloudWatch Logs — this is the
# extra grant letting the function actually poll SQS. Resource scoped to
# messaging's specific queue ARN, not "any SQS queue."
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

# This is the actual "event-driven" connection: Lambda polls the queue
# itself (event source mapping), rather than SNS pushing directly to Lambda
# — going through SQS means messages queue up safely if the consumer is
# briefly unavailable, instead of being dropped.
resource "aws_lambda_event_source_mapping" "sqs" {
  event_source_arn = module.messaging.queue_arn
  function_name    = module.consumer.function_name
  batch_size       = 5
}
