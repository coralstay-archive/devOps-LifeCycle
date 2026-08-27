module "vpc" {
  source = "../../modules/vpc"

  name               = var.name
  availability_zones = var.availability_zones
}

# num_cache_nodes=3 (1 primary + 2 replicas) overrides the module's default
# of 2 — the whole point of "read-heavy" is having enough replicas to spread
# read traffic across, not just one.
module "redis" {
  source = "../../modules/elasticache-redis"

  name               = var.name
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
  num_cache_nodes    = 3
}

module "observability" {
  source = "../../modules/observability"
  name   = var.name
}
