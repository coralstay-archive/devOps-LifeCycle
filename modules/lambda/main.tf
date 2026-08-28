# The role Lambda assumes to run the function — separate from what the
# function is allowed to do, which is handled below by the basic-execution
# policy attachment.
resource "aws_iam_role" "this" {
  name = "${var.function_name}-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = { Service = "lambda.amazonaws.com" }
      Action    = "sts:AssumeRole"
    }]
  })

  tags = var.tags
}

# Minimum viable permission: write logs to CloudWatch. Anything beyond that
# (DynamoDB access, S3, etc.) is workload-specific and deliberately not
# baked into this generic module.
resource "aws_iam_role_policy_attachment" "basic_execution" {
  role       = aws_iam_role.this.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# Required for tracing_config below to actually write anything to X-Ray —
# without this permission, Active tracing silently produces no traces.
resource "aws_iam_role_policy_attachment" "xray" {
  role       = aws_iam_role.this.name
  policy_arn = "arn:aws:iam::aws:policy/AWSXRayDaemonWriteAccess"
}

# Only needed when the function is VPC-attached below — Lambda has to
# create/manage ENIs in the given subnets, which requires this specific
# managed policy beyond basic execution.
resource "aws_iam_role_policy_attachment" "vpc_access" {
  count = length(var.subnet_ids) > 0 ? 1 : 0

  role       = aws_iam_role.this.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
}

# Declared explicitly (with a real retention period) instead of letting
# Lambda auto-create it — Lambda's auto-created log group defaults to never
# expiring, which quietly accumulates cost forever.
resource "aws_cloudwatch_log_group" "this" {
  name              = "/aws/lambda/${var.function_name}"
  retention_in_days = var.log_retention_days
  kms_key_id        = var.log_kms_key_arn
  tags              = var.tags
}

resource "aws_lambda_function" "this" {
  function_name = var.function_name
  filename      = var.filename
  # Forces Terraform to detect code changes: without a source_code_hash tied
  # to the actual zip contents, Terraform has no way to know the deployment
  # package changed and would skip updating the function.
  source_code_hash = filebase64sha256(var.filename)
  handler          = var.handler
  runtime          = var.runtime
  role             = aws_iam_role.this.arn
  memory_size      = var.memory_size
  timeout          = var.timeout

  reserved_concurrent_executions = var.reserved_concurrent_executions
  kms_key_arn                    = var.kms_key_arn
  code_signing_config_arn        = var.code_signing_config_arn

  environment {
    variables = var.environment_variables
  }

  # Attaches the function to a VPC only when subnet_ids is non-empty — this
  # is a real trade-off, not just a toggle: a VPC-attached function's
  # network path goes through an ENI instead of the Lambda service network,
  # which adds cold-start latency (mitigated but not eliminated by AWS's
  # Hyperplane ENI model). Only set this when the function actually needs to
  # reach something private (e.g. rds-postgres, elasticache-redis).
  dynamic "vpc_config" {
    for_each = length(var.subnet_ids) > 0 ? [1] : []
    content {
      subnet_ids         = var.subnet_ids
      security_group_ids = var.security_group_ids
    }
  }

  # Free observability win: samples and records request traces with no
  # code changes needed, as long as the xray policy attachment above exists.
  tracing_config {
    mode = "Active"
  }

  # Only added when the caller wants failed async invocations captured
  # somewhere inspectable instead of just retried/dropped.
  dynamic "dead_letter_config" {
    for_each = var.dead_letter_target_arn == null ? [] : [1]
    content {
      target_arn = var.dead_letter_target_arn
    }
  }

  tags = var.tags

  # 128-10240 MB is Lambda's actual valid range, not a value this module
  # invented — outside it the API rejects the function outright.
  lifecycle {
    precondition {
      condition     = var.memory_size >= 128 && var.memory_size <= 10240
      error_message = "memory_size must be between 128 and 10240 MB — this is a Lambda API requirement, not just a style preference."
    }
  }

  # Explicit dependency: the log group should exist before the function
  # starts writing to it, even though nothing in the function's own
  # arguments references the log group to make that ordering implicit.
  # aws_iam_role_policy_attachment.vpc_access is included too — when
  # subnet_ids is set, Lambda needs that permission in place before it can
  # create the function's ENIs, and nothing in the function's own arguments
  # references the policy attachment to make that ordering implicit either.
  depends_on = [aws_cloudwatch_log_group.this, aws_iam_role_policy_attachment.vpc_access]
}
