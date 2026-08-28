# One topic all alarms fan into — keeps notification wiring (email, and
# whatever Slack/PagerDuty integration gets added later) in one place instead
# of per-alarm.
resource "aws_sns_topic" "alarms" {
  name = "${var.name}-alarms"
  tags = var.tags

  # Falls back to the AWS-managed key when kms_key_arn isn't set — same
  # "encryption on by default costs nothing" call as s3-bucket's SSE-S3.
  kms_master_key_id = coalesce(var.kms_key_arn, "alias/aws/sns")

  # Cheap sanity check that the resource actually produced a usable ARN —
  # mainly here as the pattern other modules follow (see s3-bucket's
  # bucket_arn precondition for the same idea on an output instead of a
  # resource).
  lifecycle {
    postcondition {
      condition     = startswith(self.arn, "arn:aws:sns:")
      error_message = "alarms topic ARN must be a well-formed SNS ARN."
    }
  }
}

# Optional — most real setups would route through Slack/PagerDuty instead,
# but email is the zero-setup default so this module works out of the box.
resource "aws_sns_topic_subscription" "email" {
  count     = var.alarm_email == null ? 0 : 1
  topic_arn = aws_sns_topic.alarms.arn
  protocol  = "email"
  endpoint  = var.alarm_email
}

# A generic alarm factory: the caller supplies a map of alarm configs (metric
# name, threshold, etc.) via var.alarms, and this for_each turns each map
# entry into one CloudWatch alarm wired to the shared SNS topic above.
resource "aws_cloudwatch_metric_alarm" "this" {
  for_each = var.alarms

  alarm_name          = "${var.name}-${each.key}"
  metric_name         = each.value.metric_name
  namespace           = each.value.namespace
  statistic           = each.value.statistic
  period              = each.value.period
  evaluation_periods  = each.value.evaluation_periods
  threshold           = each.value.threshold
  comparison_operator = each.value.comparison_operator
  dimensions          = each.value.dimensions

  alarm_actions = [aws_sns_topic.alarms.arn]
  ok_actions    = [aws_sns_topic.alarms.arn]

  tags = var.tags
}

# A minimal starter dashboard — just a markdown widget pointing back at the
# stack's SLO.md, rather than trying to guess useful metric widgets before
# any real alarms exist. Extend this once var.alarms is populated for real.
resource "aws_cloudwatch_dashboard" "this" {
  dashboard_name = var.name

  dashboard_body = jsonencode({
    widgets = [
      {
        type   = "text"
        x      = 0
        y      = 0
        width  = 24
        height = 2
        properties = {
          markdown = "# ${var.name}\nSee this stack's SLO.md for availability/latency targets and error budget policy."
        }
      }
    ]
  })
}
