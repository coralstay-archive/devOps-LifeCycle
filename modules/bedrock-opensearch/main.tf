resource "aws_opensearchserverless_security_policy" "encryption" {
  name = "${var.name}-encryption"
  type = "encryption"

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

  policy = jsonencode([{
    Rules = [{
      ResourceType = "collection"
      Resource     = ["collection/${var.name}"]
    }]
    AllowFromPublic = true
  }])
}

resource "aws_opensearchserverless_collection" "this" {
  name = var.name
  type = "VECTORSEARCH"

  tags = var.tags

  depends_on = [
    aws_opensearchserverless_security_policy.encryption,
    aws_opensearchserverless_security_policy.network,
  ]

  lifecycle {
    precondition {
      condition     = can(regex("^[a-z][a-z0-9-]{2,31}$", var.name))
      error_message = "name must be 3-32 chars, lowercase, starting with a letter — OpenSearch Serverless collection naming rule."
    }
  }
}

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
