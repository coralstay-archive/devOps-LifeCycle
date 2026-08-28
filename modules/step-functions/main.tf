resource "aws_iam_role" "this" {
  name = "${var.name}-sfn-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = { Service = "states.amazonaws.com" }
      Action    = "sts:AssumeRole"
    }]
  })

  tags = var.tags
}

# Empty by default (var.policy_arns defaults to []) — a state machine with no
# attached policies can still run, it just can't call any other AWS
# services from its states. Attach whatever the actual workflow needs (e.g.
# Lambda invoke permissions).
resource "aws_iam_role_policy_attachment" "this" {
  for_each   = toset(var.policy_arns)
  role       = aws_iam_role.this.name
  policy_arn = each.value
}

# Required for tracing_configuration below to actually write anything to
# X-Ray — without this permission, Active tracing silently produces no traces.
resource "aws_iam_role_policy_attachment" "xray" {
  role       = aws_iam_role.this.name
  policy_arn = "arn:aws:iam::aws:policy/AWSXRayDaemonWriteAccess"
}

# Step Functions' CloudWatch Logs integration needs this exact set of
# actions (not just logs:PutLogEvents) — it manages its own "log delivery"
# resource under the hood rather than writing directly, which is why a
# generic CloudWatchLogsFullAccess-style policy isn't the actual requirement
# here. This is AWS's documented minimum for logging_configuration to work.
resource "aws_iam_role_policy" "logging" {
  name = "${var.name}-sfn-logging"
  role = aws_iam_role.this.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = [
        "logs:CreateLogDelivery",
        "logs:GetLogDelivery",
        "logs:UpdateLogDelivery",
        "logs:DeleteLogDelivery",
        "logs:ListLogDeliveries",
        "logs:PutResourcePolicy",
        "logs:DescribeResourcePolicies",
        "logs:DescribeLogGroups",
      ]
      Resource = "*"
    }]
  })
}

resource "aws_cloudwatch_log_group" "this" {
  name              = "/aws/vendedlogs/states/${var.name}"
  retention_in_days = var.log_retention_days
  kms_key_id        = var.log_kms_key_arn
  tags              = var.tags
}

resource "aws_sfn_state_machine" "this" {
  name       = var.name
  role_arn   = aws_iam_role.this.arn
  definition = var.definition

  # Free observability wins: ERROR-level history goes to CloudWatch Logs,
  # and X-Ray sampling is on — neither requires touching the state machine
  # definition itself.
  logging_configuration {
    log_destination        = "${aws_cloudwatch_log_group.this.arn}:*"
    include_execution_data = true
    level                  = "ERROR"
  }

  tracing_configuration {
    enabled = true
  }

  tags = var.tags

  # Amazon States Language is JSON, not HCL — a syntax error here would
  # otherwise surface as an opaque failure deep in the Step Functions API
  # instead of at plan time.
  lifecycle {
    precondition {
      condition     = can(jsondecode(var.definition))
      error_message = "definition must be valid JSON — Amazon States Language is JSON, not HCL."
    }
  }
}
