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
}

module "backup" {
  source        = "../../modules/aws-backup"
  name          = var.name
  resource_arns = [module.rds.arn]
}
