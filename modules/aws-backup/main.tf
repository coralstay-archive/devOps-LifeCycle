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

    lifecycle {
      delete_after = var.retention_days
    }
  }

  tags = var.tags
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

resource "aws_backup_selection" "this" {
  name         = "${var.name}-selection"
  plan_id      = aws_backup_plan.this.id
  iam_role_arn = aws_iam_role.this.arn
  resources    = var.resource_arns
}
