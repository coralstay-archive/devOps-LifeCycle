module "vpc" {
  source = "../../modules/vpc"

  name               = var.name
  availability_zones = var.availability_zones
}

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
