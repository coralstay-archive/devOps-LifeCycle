module "vpc" {
  source = "../../modules/vpc"

  name               = var.name
  availability_zones = var.availability_zones
}

module "ecr" {
  source = "../../modules/ecr"
  name   = var.name
}

module "alb" {
  source = "../../modules/alb"

  name              = var.name
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  target_port       = 80
}

module "ecs_service" {
  source = "../../modules/ecs-service"

  name               = var.name
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
  container_image    = var.container_image
  container_port     = 80
  target_group_arn   = module.alb.target_group_arn
}

module "rds" {
  source = "../../modules/rds-postgres"

  identifier                 = var.name
  vpc_id                     = module.vpc.vpc_id
  private_subnet_ids         = module.vpc.private_subnet_ids
  allowed_security_group_ids = [module.ecs_service.security_group_id]
}

module "observability" {
  source = "../../modules/observability"
  name   = var.name
}
