# Minimal working example: vpc + s3-bucket only. This is a scaled-down
# stand-in for the `standard-web` scenario (which will eventually also add
# ecs-service, rds-postgres, and observability once those modules are built).

module "vpc" {
  source = "../../modules/vpc"

  name               = var.name
  availability_zones = var.availability_zones
}

module "bucket" {
  source = "../../modules/s3-bucket"

  bucket_name = "${var.name}-${data.aws_caller_identity.current.account_id}"
}

data "aws_caller_identity" "current" {}
