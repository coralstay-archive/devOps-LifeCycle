module "vpc" {
  source = "../../modules/vpc"

  name               = var.name
  availability_zones = var.availability_zones
}

# node_desired_size/node_max_size raised above the eks module's defaults
# (2/4) to 3/6 — multiple tenants sharing one cluster need more headroom
# than a single-tenant deployment would.
module "eks" {
  source = "../../modules/eks"

  cluster_name       = var.name
  private_subnet_ids = module.vpc.private_subnet_ids
  node_desired_size  = 3
  node_max_size      = 6
}

module "observability" {
  source = "../../modules/observability"
  name   = var.name
}
