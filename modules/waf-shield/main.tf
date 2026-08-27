resource "aws_wafv2_web_acl" "this" {
  name  = var.name
  scope = var.scope

  # default_action = allow means the Web ACL is allow-by-default, only
  # blocking what an explicit rule below says to block — the more common
  # posture than starting from deny-everything.
  default_action {
    allow {}
  }

  # AWS's own curated rule set covering common attack patterns (SQLi, XSS,
  # etc.) — override_action = none means AWS's own block/count decisions
  # inside this rule group are respected as-is, not overridden.
  rule {
    name     = "aws-managed-common"
    priority = 0

    override_action {
      none {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesCommonRuleSet"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "${var.name}-common"
      sampled_requests_enabled   = true
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = var.name
    sampled_requests_enabled   = true
  }

  tags = var.tags

  # WAFv2's only two valid scope values — REGIONAL (ALB, API Gateway) or
  # CLOUDFRONT (which additionally requires the provider itself to be in
  # us-east-1, a constraint this precondition can't check but the README
  # documents).
  lifecycle {
    precondition {
      condition     = contains(["REGIONAL", "CLOUDFRONT"], var.scope)
      error_message = "scope must be REGIONAL or CLOUDFRONT — WAFv2's only valid values."
    }
  }
}

# Only applies to REGIONAL resources (ALB) — CloudFront attaches a Web ACL
# via its own web_acl_id argument instead of a separate association
# resource, which is why this is conditioned on scope too, not just on
# resource_arn being set.
resource "aws_wafv2_web_acl_association" "this" {
  count        = var.scope == "REGIONAL" && var.resource_arn != null ? 1 : 0
  resource_arn = var.resource_arn
  web_acl_arn  = aws_wafv2_web_acl.this.arn
}

# Opt-in and separate from the Web ACL above: Shield Advanced requires an
# active paid subscription on the account, so this shouldn't be created
# unconditionally.
resource "aws_shield_protection" "this" {
  count        = var.enable_shield_advanced && var.resource_arn != null ? 1 : 0
  name         = var.name
  resource_arn = var.resource_arn

  tags = var.tags
}
