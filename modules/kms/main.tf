resource "aws_kms_key" "this" {
  description             = "Key for ${var.name}"
  deletion_window_in_days = var.deletion_window_in_days
  enable_key_rotation     = true

  tags = var.tags

  lifecycle {
    precondition {
      condition     = var.deletion_window_in_days >= 7 && var.deletion_window_in_days <= 30
      error_message = "deletion_window_in_days must be between 7 and 30 — this is a KMS API requirement, not just a style preference."
    }
  }
}

resource "aws_kms_alias" "this" {
  name          = "alias/${var.name}"
  target_key_id = aws_kms_key.this.key_id
}
