# override_resource gives aws_s3_bucket.this.arn a realistic value — the mock
# would otherwise generate a schema-valid-but-fake string that trips the
# module's own bucket_arn output precondition (see outputs.tf).
mock_provider "aws" {
  override_resource {
    target = aws_s3_bucket.this
    values = {
      arn = "arn:aws:s3:::test-bucket-12345"
    }
  }
}

run "defaults_are_versioned_and_fully_blocked_from_public_access" {
  variables {
    bucket_name = "test-bucket-12345"
  }

  assert {
    condition     = aws_s3_bucket_versioning.this.versioning_configuration[0].status == "Enabled"
    error_message = "versioning should default to Enabled"
  }

  assert {
    condition = alltrue([
      aws_s3_bucket_public_access_block.this.block_public_acls,
      aws_s3_bucket_public_access_block.this.block_public_policy,
      aws_s3_bucket_public_access_block.this.ignore_public_acls,
      aws_s3_bucket_public_access_block.this.restrict_public_buckets,
    ])
    error_message = "all four public access block flags must default to true"
  }
}

run "versioning_can_be_suspended" {
  variables {
    bucket_name        = "test-bucket-12345"
    versioning_enabled = false
  }

  assert {
    condition     = aws_s3_bucket_versioning.this.versioning_configuration[0].status == "Suspended"
    error_message = "versioning_enabled = false should suspend versioning"
  }
}
