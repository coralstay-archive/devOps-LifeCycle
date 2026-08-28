# The catalog database is just a namespace — the crawler below is what
# actually populates it with table definitions inferred from the data in S3.
resource "aws_glue_catalog_database" "this" {
  name = var.database_name

  # Glue catalog names specifically disallow hyphens (unlike almost every
  # other AWS resource name) — this catches the common mistake of reusing a
  # hyphenated project name directly.
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

# Lets the crawler itself run and write results to the Data Catalog.
resource "aws_iam_role_policy_attachment" "glue_service" {
  role       = aws_iam_role.crawler.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole"
}

# Lets the crawler actually read the S3 data it's supposed to infer a schema
# from. Broad (whole-account S3 read) for simplicity — scope to the specific
# bucket for anything handling sensitive data.
resource "aws_iam_role_policy_attachment" "s3_read" {
  role       = aws_iam_role.crawler.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}

# Encrypts the crawler's own S3 reads, job bookmarks, and CloudWatch logs.
# Modes flip to DISABLED (Glue's own default) when no key is supplied —
# opt-in rather than silently creating a key this module didn't ask
# permission to own.
resource "aws_glue_security_configuration" "this" {
  name = "${var.database_name}-security-config"

  encryption_configuration {
    cloudwatch_encryption {
      cloudwatch_encryption_mode = var.kms_key_arn == null ? "DISABLED" : "SSE-KMS"
      kms_key_arn                = var.kms_key_arn
    }

    job_bookmarks_encryption {
      job_bookmarks_encryption_mode = var.kms_key_arn == null ? "DISABLED" : "CSE-KMS"
      kms_key_arn                   = var.kms_key_arn
    }

    s3_encryption {
      s3_encryption_mode = var.kms_key_arn == null ? "DISABLED" : "SSE-KMS"
      kms_key_arn        = var.kms_key_arn
    }
  }
}

# Scans the S3 path, infers a schema, and writes table definitions into the
# catalog database above. schedule is optional (null = on-demand only) since
# most data doesn't need continuous re-crawling.
resource "aws_glue_crawler" "this" {
  name                   = "${var.database_name}-crawler"
  database_name          = aws_glue_catalog_database.this.name
  role                   = aws_iam_role.crawler.arn
  schedule               = var.crawler_schedule
  security_configuration = aws_glue_security_configuration.this.name

  s3_target {
    path = var.s3_target_path
  }

  tags = var.tags
}
