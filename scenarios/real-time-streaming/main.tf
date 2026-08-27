module "vpc" {
  source = "../../modules/vpc"

  name               = var.name
  availability_zones = var.availability_zones
}

# private_subnet_ids from vpc feeds msk-kafka's own internal precondition
# (broker count must be a multiple of subnet count) — with vpc's default 2
# AZs and this module's default 2 brokers, that's satisfied automatically.
module "kafka" {
  source = "../../modules/msk-kafka"

  cluster_name       = var.name
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
}

module "observability" {
  source = "../../modules/observability"
  name   = var.name
}
