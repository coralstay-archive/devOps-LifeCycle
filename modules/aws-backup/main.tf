# Where backups actually get stored — separate resource from the plan
# (schedule/retention rules) below, since one vault could receive backups
# from multiple plans.
resource "aws_backup_vault" "this" {
  name = "${var.name}-vault"
  tags = var.tags
}

resource "aws_backup_plan" "this" {
  name = "${var.name}-plan"

  rule {
    rule_name         = "daily"
    target_vault_name = aws_backup_vault.this.name
    schedule          = var.schedule

    # NOTE: this `lifecycle` block is an AWS Backup *rule argument*
    # (retention policy for backups this rule creates) — a completely
    # different concept from the Terraform meta-argument `lifecycle` block
    # below on this same resource. They just happen to share a name.
    lifecycle {
      delete_after = var.retention_days
    }
  }

  tags = var.tags

  # This is the OTHER lifecycle — Terraform's own meta-argument, used here
  # for a precondition. retention_days < 1 would mean "delete backups
  # immediately," which defeats the point of backing anything up.
  lifecycle {
    precondition {
      condition     = var.retention_days >= 1
      error_message = "retention_days must be at least 1."
    }
  }
}

resource "aws_iam_role" "this" {
  name = "${var.name}-backup-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = { Service = "backup.amazonaws.com" }
      Action    = "sts:AssumeRole"
    }]
  })

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "this" {
  role       = aws_iam_role.this.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"
}

# Ties it all together: WHICH resources (var.resource_arns) get backed up by
# WHICH plan, using WHICH role's permissions. An empty resource_arns list is
# valid at plan time but means "backs up nothing" — worth double-checking
# when actually using this module.
resource "aws_backup_selection" "this" {
  name         = "${var.name}-selection"
  plan_id      = aws_backup_plan.this.id
  iam_role_arn = aws_iam_role.this.arn
  resources    = var.resource_arns
}
