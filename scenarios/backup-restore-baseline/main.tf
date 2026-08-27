module "vpc" {
  source = "../../modules/vpc"

  name               = var.name
  availability_zones = var.availability_zones
}

# Full default instance size here (unlike disaster-recovery-pilot-light's
# deliberately-shrunk standby) — this scenario is about the backup policy
# itself, not about minimizing standby cost.
module "rds" {
  source = "../../modules/rds-postgres"

  identifier         = var.name
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
}

# Same rds.arn -> resource_arns wiring as disaster-recovery-pilot-light —
# the two scenarios share this exact connection pattern because they share
# the same underlying AWS Backup mechanism, just for different purposes.
module "backup" {
  source        = "../../modules/aws-backup"
  name          = var.name
  resource_arns = [module.rds.arn]
}
