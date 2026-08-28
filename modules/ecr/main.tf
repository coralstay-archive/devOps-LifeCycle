# IMMUTABLE tags mean once you push "myapp:v1.2.3", nobody can silently
# overwrite what that tag points to — a common source of "it worked in
# staging, prod pulled something different" bugs when tags are mutable.
# scan_on_push catches known CVEs in the image automatically.
resource "aws_ecr_repository" "this" {
  name                 = var.name
  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  encryption_configuration {
    encryption_type = var.kms_key_arn == null ? "AES256" : "KMS"
    kms_key         = var.kms_key_arn
  }

  tags = var.tags

  # untagged images accumulate fast (every build that doesn't get tagged
  # leaves one behind) and cost storage for no benefit — this needs to be a
  # real positive number of days, not zero/negative.
  lifecycle {
    precondition {
      condition     = var.untagged_image_expiry_days >= 1
      error_message = "untagged_image_expiry_days must be at least 1."
    }
  }
}

# Without this, untagged images pile up forever — IMMUTABLE tags mean you
# can't overwrite a tag, so every rebuild-without-a-new-tag leaves an
# orphaned untagged image behind.
resource "aws_ecr_lifecycle_policy" "this" {
  repository = aws_ecr_repository.this.name

  policy = jsonencode({
    rules = [{
      rulePriority = 1
      description  = "Expire untagged images"
      selection = {
        tagStatus   = "untagged"
        countType   = "sinceImagePushed"
        countUnit   = "days"
        countNumber = var.untagged_image_expiry_days
      }
      action = { type = "expire" }
    }]
  })
}
