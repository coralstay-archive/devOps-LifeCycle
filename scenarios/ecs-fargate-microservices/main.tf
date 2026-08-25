module "vpc" {
  source = "../../modules/vpc"

  name               = var.name
  availability_zones = var.availability_zones
}

module "alb" {
  source   = "../../modules/alb"
  for_each = toset(var.services)

  name              = "${var.name}-${each.key}"
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  target_port       = 80
}

module "service" {
  source   = "../../modules/ecs-service"
  for_each = toset(var.services)

  name               = "${var.name}-${each.key}"
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
  container_image    = var.container_image
  container_port     = 80
  target_group_arn   = module.alb[each.key].target_group_arn
}
