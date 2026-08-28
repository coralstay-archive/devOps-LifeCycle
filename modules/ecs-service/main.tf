# The logical grouping ECS services/tasks run inside. Cheap and mostly
# inert on its own — the interesting parts are the task definition and
# service below.
resource "aws_ecs_cluster" "this" {
  name = "${var.name}-cluster"

  # Real per-container cost when enabled (extra CloudWatch metrics beyond
  # task-level) — off by default so this scaffold doesn't silently bill for it.
  setting {
    name  = "containerInsights"
    value = var.enable_container_insights ? "enabled" : "disabled"
  }

  tags = var.tags
}

# The EXECUTION role: used by the ECS agent itself to pull the container
# image and write logs — not the same as a "task role" (which your
# application code would use to call other AWS APIs, and which this minimal
# module doesn't create since it depends on what the app actually needs).
resource "aws_iam_role" "execution" {
  name = "${var.name}-ecs-execution"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = { Service = "ecs-tasks.amazonaws.com" }
      Action    = "sts:AssumeRole"
    }]
  })

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "execution" {
  role       = aws_iam_role.execution.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_security_group" "service" {
  name        = "${var.name}-ecs-sg"
  description = "ECS service security group"
  vpc_id      = var.vpc_id
  tags        = var.tags
}

# Fargate tasks use awsvpc networking, meaning each task gets its own ENI —
# so the security group has to allow the container port directly, there's no
# host-level port mapping to reason about like with EC2 launch type.
#
# Scoped to the ALB's security group when one is given — traffic is only
# ever supposed to arrive via the ALB, so 0.0.0.0/0 is a wider hole than
# necessary. Falls back to 0.0.0.0/0 only for the no-ALB case (a caller
# reaching the service directly, e.g. via a Cloud Map/service-discovery
# setup this minimal module doesn't build).
resource "aws_vpc_security_group_ingress_rule" "container_port_from_alb" {
  count                        = var.alb_security_group_id == null ? 0 : 1
  security_group_id            = aws_security_group.service.id
  referenced_security_group_id = var.alb_security_group_id
  from_port                    = var.container_port
  to_port                      = var.container_port
  ip_protocol                  = "tcp"
  description                  = "Container port from the ALB's security group only"
}

resource "aws_vpc_security_group_ingress_rule" "container_port_open" {
  count             = var.alb_security_group_id == null ? 1 : 0
  security_group_id = aws_security_group.service.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = var.container_port
  to_port           = var.container_port
  ip_protocol       = "tcp"
  description       = "No ALB security group given — falls back to open ingress on the container port"
}

resource "aws_vpc_security_group_egress_rule" "all" {
  security_group_id = aws_security_group.service.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
  description       = "Unrestricted egress — pulls the container image from ECR, talks to other AWS APIs"
}

# Fargate specifically (requires_compatibilities), awsvpc networking mode
# (mandatory for Fargate). The container_definitions JSON is intentionally
# minimal — no health check, no logging driver config — since those are
# workload-specific.
resource "aws_ecs_task_definition" "this" {
  family                   = var.name
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = var.cpu
  memory                   = var.memory
  execution_role_arn       = aws_iam_role.execution.arn

  container_definitions = jsonencode([
    {
      name         = var.name
      image        = var.container_image
      portMappings = [{ containerPort = var.container_port }]
      essential    = true
    }
  ])

  tags = var.tags
}

resource "aws_ecs_service" "this" {
  name            = var.name
  cluster         = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.this.arn
  desired_count   = var.desired_count
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = var.private_subnet_ids
    security_groups = [aws_security_group.service.id]
  }

  # Only attach a load balancer if the caller actually gave us one — running
  # standalone (e.g. a worker service with no inbound traffic) is a valid
  # use case this dynamic block has to support.
  dynamic "load_balancer" {
    for_each = var.target_group_arn == null ? [] : [1]
    content {
      target_group_arn = var.target_group_arn
      container_name   = var.name
      container_port   = var.container_port
    }
  }

  tags = var.tags

  # An empty subnet list would mean "nowhere to run this service" — ECS
  # would reject it, but with a less specific error than this.
  lifecycle {
    precondition {
      condition     = length(var.private_subnet_ids) > 0
      error_message = "private_subnet_ids must not be empty — ECS cannot place tasks without at least one subnet."
    }
  }
}
