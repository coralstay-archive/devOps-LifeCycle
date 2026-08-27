resource "aws_glue_catalog_database" "this" {
  name = var.database_name

  lifecycle {
    precondition {
      condition     = can(regex("^[a-z0-9_]+$", var.database_name))
      error_message = "database_name must be lowercase alphanumeric/underscore only — Glue catalog naming rule (hyphens aren't allowed, unlike most AWS resource names)."
    }
  }
}

resource "aws_iam_role" "crawler" {
  name = "${var.database_name}-glue-crawler"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = { Service = "glue.amazonaws.com" }
      Action    = "sts:AssumeRole"
    }]
  })

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "glue_service" {
  role       = aws_iam_role.crawler.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole"
}

resource "aws_iam_role_policy_attachment" "s3_read" {
  role       = aws_iam_role.crawler.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}

resource "aws_glue_crawler" "this" {
  name          = "${var.database_name}-crawler"
  database_name = aws_glue_catalog_database.this.name
  role          = aws_iam_role.crawler.arn
  schedule      = var.crawler_schedule

  s3_target {
    path = var.s3_target_path
  }

  tags = var.tags
}
