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

resource "aws_sfn_state_machine" "this" {
  name       = var.name
  role_arn   = aws_iam_role.this.arn
  definition = var.definition

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
