module "vpc" {
  source = "../../modules/vpc"

  name               = var.name
  availability_zones = var.availability_zones
}

module "eks" {
  source = "../../modules/eks"

  cluster_name       = var.name
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
  node_desired_size  = 3
  node_max_size      = 6
}

module "observability" {
  source = "../../modules/observability"
  name   = var.name
}
