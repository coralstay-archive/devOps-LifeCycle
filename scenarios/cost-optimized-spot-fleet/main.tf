module "vpc" {
  source = "../../modules/vpc"

  name               = var.name
  availability_zones = var.availability_zones
}

module "ecs_service" {
  source = "../../modules/ecs-service"

  name               = var.name
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
  container_image    = var.container_image
}
