# OpenSearch Serverless requires explicit security policies before a
# collection can even be created — unlike the classic managed OpenSearch
# service, there's no "just create it with defaults" path.
resource "aws_opensearchserverless_security_policy" "encryption" {
  name = "${var.name}-encryption"
  type = "encryption"

  # AWSOwnedKey = true: encrypted with an AWS-owned key, no separate KMS key
  # to manage. Switch to a customer-managed key if you need to control/audit
  # key access independently.
  policy = jsonencode({
    Rules = [{
      ResourceType = "collection"
      Resource     = ["collection/${var.name}"]
    }]
    AWSOwnedKey = true
  })
}

resource "aws_opensearchserverless_security_policy" "network" {
  name = "${var.name}-network"
  type = "network"

  # AllowFromPublic = true is the quick-start default for this module —
  # restrict to a VPC-only network policy before using this for anything
  # beyond a prototype.
  policy = jsonencode([{
    Rules = [{
      ResourceType = "collection"
      Resource     = ["collection/${var.name}"]
    }]
    AllowFromPublic = true
  }])
}

# VECTORSEARCH type specifically: this is what makes the collection usable
# as a RAG vector store, as opposed to OpenSearch Serverless's other
# collection types (e.g. time series, search).
resource "aws_opensearchserverless_collection" "this" {
  name = var.name
  type = "VECTORSEARCH"

  tags = var.tags

  # Explicit dependency: OpenSearch Serverless requires the security
  # policies to exist before the collection references them, but nothing in
  # this resource's arguments points at the policies by name to make that
  # ordering automatic.
  depends_on = [
    aws_opensearchserverless_security_policy.encryption,
    aws_opensearchserverless_security_policy.network,
  ]

  # OpenSearch Serverless's actual collection naming rule: 3-32 characters,
  # lowercase, starting with a letter.
  lifecycle {
    precondition {
      condition     = can(regex("^[a-z][a-z0-9-]{2,31}$", var.name))
      error_message = "name must be 3-32 chars, lowercase, starting with a letter — OpenSearch Serverless collection naming rule."
    }
  }
}

# The role Bedrock assumes to actually read/write this collection when
# answering RAG queries or building the knowledge base index.
resource "aws_iam_role" "bedrock" {
  name = "${var.name}-bedrock-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = { Service = "bedrock.amazonaws.com" }
      Action    = "sts:AssumeRole"
    }]
  })

  tags = var.tags
}

# aoss:APIAccessAll scoped to just this one collection's ARN — broad within
# that collection, but not account-wide OpenSearch Serverless access.
resource "aws_iam_role_policy" "bedrock_opensearch_access" {
  name = "${var.name}-opensearch-access"
  role = aws_iam_role.bedrock.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect   = "Allow"
      Action   = ["aoss:APIAccessAll"]
      Resource = aws_opensearchserverless_collection.this.arn
    }]
  })
}
