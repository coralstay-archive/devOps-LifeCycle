mock_provider "aws" {}

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
