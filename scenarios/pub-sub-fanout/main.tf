# Not using the sns-sqs module here since it's a 1-topic:1-queue shape;
# fanout needs 1 topic : N queues, so the topic/queues/subscriptions are
# declared directly.

resource "aws_sns_topic" "this" {
  name = "${var.name}-topic"
}

resource "aws_sqs_queue" "this" {
  for_each = toset(var.queue_names)
  name     = "${var.name}-${each.key}"
}

resource "aws_sqs_queue_policy" "allow_sns" {
  for_each  = aws_sqs_queue.this
  queue_url = each.value.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = { Service = "sns.amazonaws.com" }
      Action    = "sqs:SendMessage"
      Resource  = each.value.arn
      Condition = {
        ArnEquals = { "aws:SourceArn" = aws_sns_topic.this.arn }
      }
    }]
  })
}

resource "aws_sns_topic_subscription" "this" {
  for_each             = aws_sqs_queue.this
  topic_arn            = aws_sns_topic.this.arn
  protocol             = "sqs"
  endpoint             = each.value.arn
  raw_message_delivery = true
}
