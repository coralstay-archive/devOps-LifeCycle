# One shared VPC, but for_each below creates independent alb+ecs_service
# pairs per entry in var.services — that's the "microservices" shape: same
# network, isolated compute per service.
module "vpc" {
  source = "../../modules/vpc"

  name               = var.name
  availability_zones = var.availability_zones
}

# for_each over var.services means module.alb becomes a map — each service
# gets its own ALB (simplest approach, at the cost of one ALB's worth of
# extra cost per service; see this scenario's README for the
# listener-rules alternative).
module "alb" {
  source   = "../../modules/alb"
  for_each = toset(var.services)

  name              = "${var.name}-${each.key}"
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  target_port       = 80
}

# module.alb[each.key] — indexing the ALB map by the SAME key this module
# call iterates over is what pairs each service with its own ALB, not a
# random/mismatched one.
module "service" {
  source   = "../../modules/ecs-service"
  for_each = toset(var.services)

  name                  = "${var.name}-${each.key}"
  vpc_id                = module.vpc.vpc_id
  private_subnet_ids    = module.vpc.private_subnet_ids
  container_image       = var.container_image
  container_port        = 80
  target_group_arn      = module.alb[each.key].target_group_arn
  alb_security_group_id = module.alb[each.key].security_group_id
}
