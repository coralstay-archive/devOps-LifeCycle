module "vpc" {
  source = "../../modules/vpc"

  name               = var.name
  availability_zones = var.availability_zones
}

# The alb module creates the "blue" target group; codedeploy needs a second
# "green" one to shift traffic to during a deployment, which isn't something
# the alb module's single-target-group shape covers — declared directly here.
module "alb" {
  source = "../../modules/alb"

  name              = var.name
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  target_port       = 80
}

resource "aws_lb_target_group" "green" {
  name        = "${var.name}-green"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = module.vpc.vpc_id
  target_type = "ip"

  health_check {
    path = "/"
  }
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

module "deploy" {
  source = "../../modules/codedeploy"

  name                    = var.name
  ecs_cluster_name        = module.ecs_service.cluster_name
  ecs_service_name        = module.ecs_service.service_name
  prod_listener_arn       = module.alb.listener_arn
  target_group_blue_name  = module.alb.target_group_name
  target_group_green_name = aws_lb_target_group.green.name
}
