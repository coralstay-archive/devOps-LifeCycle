# The publish side: whatever produces events talks to this topic, with no
# knowledge of who's actually consuming them.
resource "aws_sns_topic" "this" {
  name = "${var.name}-topic"
  tags = var.tags

  # Falls back to the AWS-managed key when kms_key_arn isn't set — same
  # "encryption on by default costs nothing" call as s3-bucket's SSE-S3.
  kms_master_key_id = coalesce(var.kms_key_arn, "alias/aws/sns")
}

# The durable consume side: unlike a direct SNS subscription to, say, a
# Lambda, routing through SQS means messages survive even if the consumer is
# temporarily down — they just wait in the queue.
resource "aws_sqs_queue" "this" {
  name = "${var.name}-queue"
  tags = var.tags

  # Same rationale/fallback as the topic's kms_master_key_id above.
  kms_master_key_id = coalesce(var.kms_key_arn, "alias/aws/sqs")

  # Same "does this ARN look real" convention as the other modules'
  # postconditions — cheap, mostly documentation of intent.
  lifecycle {
    postcondition {
      condition     = startswith(self.arn, "arn:aws:sqs:")
      error_message = "Queue ARN must be a well-formed SQS ARN."
    }
  }
}

# SNS can't deliver to an SQS queue unless the queue's own policy explicitly
# allows it — and the ArnEquals condition scopes that permission to only
# *this* topic, not "any SNS topic in the account."
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

# The actual topic->queue wiring. raw_message_delivery = true strips SNS's
# own JSON envelope so the queue receives the original message body
# directly, instead of the message nested inside SNS metadata.
resource "aws_sns_topic_subscription" "queue" {
  topic_arn            = aws_sns_topic.this.arn
  protocol             = "sqs"
  endpoint             = aws_sqs_queue.this.arn
  raw_message_delivery = true
}
