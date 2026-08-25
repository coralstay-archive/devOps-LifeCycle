output "state_bucket_name" {
  value = module.state_bucket.bucket_id
}

output "lock_table_name" {
  value = aws_dynamodb_table.lock.name
}
