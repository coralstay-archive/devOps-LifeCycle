# The classic 3-tier shape: network -> compute -> data, plus the two things
# every real deployment needs alongside it (a place to push images, and
# baseline observability). Read top to bottom, this is also the dependency
# order — each module below needs an output from something above it.

module "vpc" {
  source = "../../modules/vpc"

  name               = var.name
  availability_zones = var.availability_zones
}

# No dependency on anything else here — a repository exists independently of
# any network. Created early mainly because you'd want to push an image to
# it before the ECS service below can actually start.
module "ecr" {
  source = "../../modules/ecr"
  name   = var.name
}

# ALB needs the VPC's public subnets to place itself in — an internet-facing
# load balancer has to live in subnets that actually route to an IGW.
module "alb" {
  source = "../../modules/alb"

  name              = var.name
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  target_port       = 80
}

# Wires vpc's private subnets (so tasks run off the public internet) and
# alb's target_group_arn (so the ALB actually has something to forward
# traffic to) into one service. container_port must match alb's
# target_port=80 above — that's not enforced by the type system, just by
# both being hardcoded to 80 here.
module "ecs_service" {
  source = "../../modules/ecs-service"

  name               = var.name
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
  container_image    = var.container_image
  container_port     = 80
  target_group_arn   = module.alb.target_group_arn
}

# allowed_security_group_ids = [ecs_service's SG] is the actual access
# control decision here: only the ECS service's own security group can reach
# Postgres on 5432, nothing else in the VPC.
module "rds" {
  source = "../../modules/rds-postgres"

  identifier                 = var.name
  vpc_id                     = module.vpc.vpc_id
  private_subnet_ids         = module.vpc.private_subnet_ids
  allowed_security_group_ids = [module.ecs_service.security_group_id]
}

# No inputs from the other modules — observability is intentionally
# self-contained here (see the module's README on why alarms/dashboards
# start as a generic baseline rather than being wired to specific metrics
# from day one).
module "observability" {
  source = "../../modules/observability"
  name   = var.name
}
