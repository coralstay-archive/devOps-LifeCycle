resource "aws_dynamodb_table" "this" {
  name         = var.table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = var.hash_key

  attribute {
    name = var.hash_key
    type = var.hash_key_type
  }

  point_in_time_recovery {
    enabled = true
  }

  server_side_encryption {
    enabled = true
  }

  tags = var.tags

  lifecycle {
    precondition {
      condition     = contains(["S", "N", "B"], var.hash_key_type)
      error_message = "hash_key_type must be S, N, or B — DynamoDB's only valid attribute types."
    }
  }
}
