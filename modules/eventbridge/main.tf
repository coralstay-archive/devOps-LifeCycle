# A rule is either time-based (schedule_expression, e.g. "rate(1 hour)") or
# event-pattern-based (react to specific AWS API activity/events) — never
# both, never neither.
resource "aws_cloudwatch_event_rule" "this" {
  name                = var.name
  schedule_expression = var.schedule_expression
  event_pattern       = var.event_pattern

  # If both are set, EventBridge's actual behavior is undefined/confusing
  # (which one wins?); if neither is set, the rule matches nothing and never
  # fires. The XOR here (!=  on two booleans) catches both silent-misconfig
  # cases at once.
  lifecycle {
    precondition {
      condition     = (var.schedule_expression != null) != (var.event_pattern != null)
      error_message = "Set exactly one of schedule_expression or event_pattern, not both and not neither."
    }
  }
}

# What the rule actually triggers — a single target ARN. Fan-out to multiple
# targets would mean multiple aws_cloudwatch_event_target resources, not
# supported by this minimal module yet.
resource "aws_cloudwatch_event_target" "this" {
  rule = aws_cloudwatch_event_rule.this.name
  arn  = var.target_arn
}

# EventBridge can't invoke a Lambda function unless the function's resource
# policy explicitly allows it — this grant is scoped to just this one rule's
# ARN via source_arn, not "any EventBridge rule can invoke this function."
resource "aws_lambda_permission" "allow_eventbridge" {
  count         = var.target_is_lambda ? 1 : 0
  statement_id  = "AllowEventBridge-${var.name}"
  action        = "lambda:InvokeFunction"
  function_name = var.target_arn
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.this.arn
}
