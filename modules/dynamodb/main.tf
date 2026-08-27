# PAY_PER_REQUEST (on-demand): no capacity planning needed, you pay per
# read/write instead of provisioning throughput up front — the right default
# for a module meant to be a quick, low-commitment building block.
resource "aws_dynamodb_table" "this" {
  name         = var.table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = var.hash_key

  # DynamoDB requires every key attribute used anywhere (here, the hash key)
  # to be declared up front with its type — even though the table can still
  # store many other undeclared attributes per item.
  attribute {
    name = var.hash_key
    type = var.hash_key_type
  }

  # Lets you restore the table to any point in the last 35 days — cheap
  # insurance against accidental deletes/writes, not just hardware failure.
  point_in_time_recovery {
    enabled = true
  }

  server_side_encryption {
    enabled = true
  }

  tags = var.tags

  # S/N/B are DynamoDB's only three valid attribute types (string/number/
  # binary) — anything else would be rejected by the API with a less
  # specific error than this.
  lifecycle {
    precondition {
      condition     = contains(["S", "N", "B"], var.hash_key_type)
      error_message = "hash_key_type must be S, N, or B — DynamoDB's only valid attribute types."
    }
  }
}
