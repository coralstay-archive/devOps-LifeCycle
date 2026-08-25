module "rag" {
  source = "../../modules/bedrock-opensearch"
  name   = var.name
}
