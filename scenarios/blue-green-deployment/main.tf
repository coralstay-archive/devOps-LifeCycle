module "vpc" {
  source = "../../modules/vpc"

  name               = var.name
  availability_zones = var.availability_zones
}

# alb's own target group becomes the "blue" side of the deployment below —
# nothing special done to it here, it's just the pre-existing target group
# every other scenario already uses.
module "alb" {
  source = "../../modules/alb"

  name              = var.name
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  target_port       = 80
}

# The "green" side: a second target group the alb module has no concept of
# (it only manages one). Declared directly here rather than extending the
# alb module, since blue/green is a deployment-strategy concern, not a
# baseline load-balancer concern.
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

# Registered against alb's (blue) target group by default — CodeDeploy is
# what will actually shift this service's traffic to the green target group
# during a deployment, not this module call itself.
module "ecs_service" {
  source = "../../modules/ecs-service"

  name               = var.name
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
  container_image    = var.container_image
  container_port     = 80
  target_group_arn   = module.alb.target_group_arn
}

# Ties everything together: ecs_service (which task set to manage),
# alb.listener_arn (where prod traffic currently flows), and the blue/green
# target group PAIR (alb's existing one + the green one declared above) —
# this is the one place all four pieces actually meet.
module "deploy" {
  source = "../../modules/codedeploy"

  name                    = var.name
  ecs_cluster_name        = module.ecs_service.cluster_name
  ecs_service_name        = module.ecs_service.service_name
  prod_listener_arn       = module.alb.listener_arn
  target_group_blue_name  = module.alb.target_group_name
  target_group_green_name = aws_lb_target_group.green.name
}
