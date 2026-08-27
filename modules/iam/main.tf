# The TRUST policy: which AWS services are allowed to assume this role at
# all. This is deliberately generic (any list of service principals) since
# this module exists to be the reusable pattern other modules hardcode
# per-service — compare to ecs-service's or lambda's own inline version of
# exactly this document.
data "aws_iam_policy_document" "assume" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = var.assume_role_services
    }
  }
}

resource "aws_iam_role" "this" {
  name               = var.name
  assume_role_policy = data.aws_iam_policy_document.assume.json
  tags               = var.tags

  # A role with an empty trust policy principal list is a real AWS
  # misconfiguration, not a hypothetical one — it's almost always a typo
  # (e.g. forgetting the actual service name), and it's a role literally
  # nothing can ever assume.
  lifecycle {
    precondition {
      condition     = length(var.assume_role_services) > 0
      error_message = "assume_role_services must contain at least one service principal — a role nothing can assume is never useful."
    }
  }
}

# The PERMISSION side: what the role can do, once assumed. Prefer this over
# inline_policy_json below when a suitable AWS-managed (or your own
# customer-managed) policy exists — it's reusable and shows up cleanly in
# IAM's console.
resource "aws_iam_role_policy_attachment" "managed" {
  for_each   = toset(var.managed_policy_arns)
  role       = aws_iam_role.this.name
  policy_arn = each.value
}

# Escape hatch for permissions specific enough that a standalone managed
# policy would never be reused elsewhere. count-gated so this resource
# simply doesn't exist when no inline policy is needed, rather than existing
# with an empty/null policy.
resource "aws_iam_role_policy" "inline" {
  count  = var.inline_policy_json == null ? 0 : 1
  name   = "${var.name}-inline"
  role   = aws_iam_role.this.id
  policy = var.inline_policy_json
}
