data "aws_caller_identity" "current" {}

module "vpc" {
  source = "../../modules/vpc"

  name               = var.name
  availability_zones = var.availability_zones
}

module "rds" {
  source = "../../modules/rds-postgres"

  identifier         = var.name
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
  instance_class     = "db.t4g.micro" # pilot-light sizing: small standby, scale up on failover
}

module "dr_artifacts_bucket" {
  source      = "../../modules/s3-bucket"
  bucket_name = "${var.name}-${data.aws_caller_identity.current.account_id}"
}

module "backup" {
  source        = "../../modules/aws-backup"
  name          = var.name
  resource_arns = [module.rds.arn]
}
