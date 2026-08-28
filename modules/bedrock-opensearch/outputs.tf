output "collection_endpoint" {
  description = "Collection endpoint -- used by clients/SDKs to talk to this vector store directly."
  value       = aws_opensearchserverless_collection.this.collection_endpoint
}

output "collection_arn" {
  description = "Collection ARN."
  value       = aws_opensearchserverless_collection.this.arn
}

output "bedrock_role_arn" {
  description = "ARN of the IAM role Bedrock assumes to read/write this collection -- reference this when configuring a Bedrock knowledge base against it."
  value       = aws_iam_role.bedrock.arn
}
