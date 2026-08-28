# Same network -> compute -> data shape as standard-web, but compute is EKS
# (for Karpenter's fast node provisioning under load) and the data layer
# adds Redis (absorb read spikes) and Kafka (buffer write spikes) instead of
# just a single RDS instance.

module "vpc" {
  source = "../../modules/vpc"

  name               = var.name
  availability_zones = var.availability_zones
}

# private_subnet_ids feeds both the control plane's ENIs and the managed
# node group — same subnets, two different consumers within the module.
module "eks" {
  source = "../../modules/eks"

  cluster_name       = var.name
  private_subnet_ids = module.vpc.private_subnet_ids
}

# NOT wired to eks's node security group — see this scenario's README
# "알려진 제약." The eks module doesn't expose one yet, so this is deployed
# but not actually reachable from the cluster until that's fixed by hand.
module "redis" {
  source = "../../modules/elasticache-redis"

  name               = var.name
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
}

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
