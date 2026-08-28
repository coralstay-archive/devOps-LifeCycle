# The bucket itself. Nothing about encryption/versioning/public-access lives
# here by default in AWS — each of those is its own separate resource below,
# which is why S3 buckets need so many companion resources to be "secure by
# default" instead of just declaring one block.
resource "aws_s3_bucket" "this" {
  bucket        = var.bucket_name
  force_destroy = var.force_destroy

  tags = var.tags
}

# Versioning protects against accidental overwrite/delete (including by
# Terraform itself) — old object versions stay recoverable. Required for
# Terraform state buckets specifically, since state corruption is otherwise
# unrecoverable.
resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id

  versioning_configuration {
    status = var.versioning_enabled ? "Enabled" : "Suspended"
  }
}

# SSE-S3 (AES256) by default: AWS-managed keys, no extra IAM/KMS setup
# needed. Encrypts everything at rest by default, even though nothing else
# in this module forces callers to opt in. Set kms_key_arn to switch to
# SSE-KMS with a customer-managed key instead.
resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  bucket = aws_s3_bucket.this.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = var.kms_key_arn == null ? "AES256" : "aws:kms"
      kms_master_key_id = var.kms_key_arn
    }
    bucket_key_enabled = true
  }
}

# All four flags on, always: this is the resource the s3_public_access.rego
# Conftest policy checks. A bucket can still be made public via bucket policy
# even with these set, but this closes the far more common accidental-ACL
# and accidental-policy paths to public exposure.
resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.this.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
