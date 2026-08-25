resource "aws_wafv2_web_acl" "this" {
  name  = var.name
  scope = var.scope

  default_action {
    allow {}
  }

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
}

resource "aws_wafv2_web_acl_association" "this" {
  count        = var.scope == "REGIONAL" && var.resource_arn != null ? 1 : 0
  resource_arn = var.resource_arn
  web_acl_arn  = aws_wafv2_web_acl.this.arn
}

resource "aws_shield_protection" "this" {
  count        = var.enable_shield_advanced && var.resource_arn != null ? 1 : 0
  name         = var.name
  resource_arn = var.resource_arn

  tags = var.tags
}
