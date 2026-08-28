module "vpc" {
  source = "../../modules/vpc"

  name               = var.name
  availability_zones = var.availability_zones
}

# Base cluster only — see this module's README for why the actual canary
# traffic-shifting mechanism (Argo Rollouts or App Mesh) isn't wired in yet.
# What exists here is deliberately just "the platform a canary tool would
# run on top of," not a working canary deployment.
module "eks" {
  source = "../../modules/eks"

  cluster_name       = var.name
  private_subnet_ids = module.vpc.private_subnet_ids
}

module "observability" {
  source = "../../modules/observability"
  name   = var.name
}
