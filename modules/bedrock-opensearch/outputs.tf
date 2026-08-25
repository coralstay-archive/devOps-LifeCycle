output "collection_endpoint" {
  value = aws_opensearchserverless_collection.this.collection_endpoint
}

output "collection_arn" {
  value = aws_opensearchserverless_collection.this.arn
}

output "bedrock_role_arn" {
  value = aws_iam_role.bedrock.arn
}
