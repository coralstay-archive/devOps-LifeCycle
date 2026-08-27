# enable_key_rotation on by default: AWS rotates the underlying key material
# yearly without you having to re-encrypt anything or change the key's ARN —
# there's essentially no downside to leaving this on.
resource "aws_kms_key" "this" {
  description             = "Key for ${var.name}"
  deletion_window_in_days = var.deletion_window_in_days
  enable_key_rotation     = true

  tags = var.tags

  # 7-30 days is the actual valid range KMS enforces for the waiting period
  # before a scheduled deletion becomes irreversible — not a value this
  # module invented.
  lifecycle {
    precondition {
      condition     = var.deletion_window_in_days >= 7 && var.deletion_window_in_days <= 30
      error_message = "deletion_window_in_days must be between 7 and 30 — this is a KMS API requirement, not just a style preference."
    }
  }
}

# A human-friendly alias (alias/<name>) so other resources/config can
# reference "alias/my-key" instead of memorizing a key ID/ARN that changes
# if the key is ever recreated.
resource "aws_kms_alias" "this" {
  name          = "alias/${var.name}"
  target_key_id = aws_kms_key.this.key_id
}
