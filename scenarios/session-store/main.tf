module "vpc" {
  source = "../../modules/vpc"

  name               = var.name
  availability_zones = var.availability_zones
}

# Left at the module's default (1 primary + 1 replica) — session data
# doesn't need read-heavy-caching's extra replica count, just enough HA to
# survive a single node failure without dropping every active session.
module "redis" {
  source = "../../modules/elasticache-redis"

  name               = var.name
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
}
