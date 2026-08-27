resource "aws_sns_topic" "this" {
  name = "${var.name}-topic"
  tags = var.tags
}

resource "aws_sqs_queue" "this" {
  name = "${var.name}-queue"
  tags = var.tags

  lifecycle {
    postcondition {
      condition     = startswith(self.arn, "arn:aws:sqs:")
      error_message = "Queue ARN must be a well-formed SQS ARN."
    }
  }
}

resource "aws_sqs_queue_policy" "allow_sns" {
  queue_url = aws_sqs_queue.this.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = { Service = "sns.amazonaws.com" }
      Action    = "sqs:SendMessage"
      Resource  = aws_sqs_queue.this.arn
      Condition = {
        ArnEquals = { "aws:SourceArn" = aws_sns_topic.this.arn }
      }
    }]
  })
}

resource "aws_sns_topic_subscription" "queue" {
  topic_arn            = aws_sns_topic.this.arn
  protocol             = "sqs"
  endpoint             = aws_sqs_queue.this.arn
  raw_message_delivery = true
}
