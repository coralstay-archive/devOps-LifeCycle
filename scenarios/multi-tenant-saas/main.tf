# Same network -> compute -> data shape as standard-web/high-traffic-spike,
# minus a load balancer/ECR here — the tenant-facing routing and container
# builds are assumed to be handled inside Kubernetes itself (Ingress,
# in-cluster image registry or ECR wired up separately), not by this
# scenario's infra layer.

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
}

# allowed_security_group_ids intentionally left default ([]) — same "not
# wired to EKS's node SG" gap noted in high-traffic-spike, since the eks
# module doesn't expose a node security group output yet.
module "rds" {
  source = "../../modules/rds-postgres"

  identifier         = var.name
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
}

module "observability" {
  source = "../../modules/observability"
  name   = var.name
}
