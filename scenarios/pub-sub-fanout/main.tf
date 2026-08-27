# Not using the sns-sqs module here since it's a 1-topic:1-queue shape;
# fanout needs 1 topic : N queues, so the topic/queues/subscriptions are
# declared directly.

resource "aws_sns_topic" "this" {
  name = "${var.name}-topic"
}

# One queue per entry in var.queue_names — each subscriber gets its own
# durable queue, so a slow/down subscriber doesn't affect the others.
resource "aws_sqs_queue" "this" {
  for_each = toset(var.queue_names)
  name     = "${var.name}-${each.key}"
}

# for_each mirrors aws_sqs_queue.this's keys exactly, so every queue gets
# its own SendMessage grant scoped to that one queue's ARN + this specific
# topic's ArnEquals condition — without this, SNS can't deliver to any of
# them.
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

# The actual fanout: one subscription per queue, all pointed at the same
# topic — this is what turns "one message published" into "every queue
# receives a copy."
resource "aws_sns_topic_subscription" "this" {
  for_each             = aws_sqs_queue.this
  topic_arn            = aws_sns_topic.this.arn
  protocol             = "sqs"
  endpoint             = each.value.arn
  raw_message_delivery = true
}
