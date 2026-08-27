# Same "thin pass-through" shape as ml-realtime-inference — the
# bedrock-opensearch module already is the RAG vector-store backend, this
# scenario just gives it its own named entry point.
module "rag" {
  source = "../../modules/bedrock-opensearch"
  name   = var.name
}
