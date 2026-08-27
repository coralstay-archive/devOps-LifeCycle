resource "aws_cloudwatch_event_rule" "this" {
  name                = var.name
  schedule_expression = var.schedule_expression
  event_pattern       = var.event_pattern

  lifecycle {
    precondition {
      condition     = (var.schedule_expression != null) != (var.event_pattern != null)
      error_message = "Set exactly one of schedule_expression or event_pattern, not both and not neither."
    }
  }
}

resource "aws_cloudwatch_event_target" "this" {
  rule = aws_cloudwatch_event_rule.this.name
  arn  = var.target_arn
}

resource "aws_lambda_permission" "allow_eventbridge" {
  count         = var.target_is_lambda ? 1 : 0
  statement_id  = "AllowEventBridge-${var.name}"
  action        = "lambda:InvokeFunction"
  function_name = var.target_arn
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.this.arn
}
