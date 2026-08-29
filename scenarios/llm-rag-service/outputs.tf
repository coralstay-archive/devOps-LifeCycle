output "collection_endpoint" {
  description = "OpenSearch Serverless collection endpoint holding the RAG vector index."
  value       = module.rag.collection_endpoint
}
