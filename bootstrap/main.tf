module "state_bucket" {
  source = "../modules/s3-bucket"

  bucket_name        = var.state_bucket_name
  versioning_enabled = true
  force_destroy      = false
}

resource "aws_dynamodb_table" "lock" {
  name         = var.lock_table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
