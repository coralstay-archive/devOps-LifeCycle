module "vpc" {
  source = "../../modules/vpc"

  name               = var.name
  availability_zones = var.availability_zones
}

# Just vpc_id + private_subnet_ids in — Redshift is the only compute/data
# resource in this scenario, so there's no cross-module wiring beyond
# network placement.
module "redshift" {
  source = "../../modules/redshift"

  cluster_identifier = var.name
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
}
