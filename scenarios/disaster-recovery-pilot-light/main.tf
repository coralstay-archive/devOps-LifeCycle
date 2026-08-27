data "aws_caller_identity" "current" {}

module "vpc" {
  source = "../../modules/vpc"

  name               = var.name
  availability_zones = var.availability_zones
}

# instance_class overridden to the smallest option — "pilot light" means
# this standby stays minimally sized until a real failover, rather than
# running at full production capacity all the time.
module "rds" {
  source = "../../modules/rds-postgres"

  identifier         = var.name
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
  instance_class     = "db.t4g.micro" # pilot-light sizing: small standby, scale up on failover
}

# Storage for DR artifacts (e.g. exported snapshots) — independent of rds,
# not wired to it directly, since actual snapshot export is an operational
# step, not something this scenario automates yet.
module "dr_artifacts_bucket" {
  source      = "../../modules/s3-bucket"
  bucket_name = "${var.name}-${data.aws_caller_identity.current.account_id}"
}

# resource_arns = [rds's own arn output] — this is what actually connects
# the backup plan to something real, instead of aws-backup's default empty
# list (which would back up nothing).
module "backup" {
  source        = "../../modules/aws-backup"
  name          = var.name
  resource_arns = [module.rds.arn]
}
