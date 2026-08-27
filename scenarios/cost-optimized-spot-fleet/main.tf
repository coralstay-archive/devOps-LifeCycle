module "vpc" {
  source = "../../modules/vpc"

  name               = var.name
  availability_zones = var.availability_zones
}

# Plain on-demand Fargate here — see this scenario's README for why Spot
# isn't actually wired in yet (ecs-service has no capacity_provider_strategy
# input to plug FARGATE_SPOT into). This module call is the baseline compute
# that a future capacity-provider change would apply to.
module "ecs_service" {
  source = "../../modules/ecs-service"

  name               = var.name
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
  container_image    = var.container_image
}
