resource "aws_security_group" "this" {
  name        = "${var.name}-alb-sg"
  description = "Allow inbound HTTP/HTTPS from the internet"
  vpc_id      = var.vpc_id
  tags        = var.tags
}

resource "aws_vpc_security_group_ingress_rule" "http" {
  security_group_id = aws_security_group.this.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
  description       = "Public HTTP — forwards directly if no cert, else redirects to HTTPS"
}

# Only opened when there's actually a cert to serve HTTPS with — no point
# accepting 443 traffic the ALB has nothing to terminate TLS for.
resource "aws_vpc_security_group_ingress_rule" "https" {
  count             = var.certificate_arn == null ? 0 : 1
  security_group_id = aws_security_group.this.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
  description       = "Public HTTPS"
}

resource "aws_vpc_security_group_egress_rule" "all" {
  security_group_id = aws_security_group.this.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
  description       = "Unrestricted egress to reach the target group across any subnet/AZ"
}

resource "aws_lb" "this" {
  name               = var.name
  internal           = false
  load_balancer_type = "application"
  subnets            = var.public_subnet_ids
  security_groups    = [aws_security_group.this.id]

  # Free hardening with no behavior tradeoff — rejects requests smuggling
  # invalid header fields instead of passing them through.
  drop_invalid_header_fields = true

  tags = var.tags

  # Not a style preference — the ALB API itself refuses to create a load
  # balancer that isn't spread across at least two AZs, for the same
  # single-AZ-failure reason NAT gateways get one per AZ elsewhere in this
  # repo.
  lifecycle {
    precondition {
      condition     = length(var.public_subnet_ids) >= 2
      error_message = "public_subnet_ids must span at least 2 AZs — this is an ALB API requirement, not just a style preference."
    }
  }
}

# One target group, IP-target-type (required for Fargate's awsvpc
# networking — instance-target-type wouldn't work since tasks don't have
# their own EC2 instance ID).
resource "aws_lb_target_group" "this" {
  name        = var.name
  port        = var.target_port
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    path = var.health_check_path
  }

  tags = var.tags
}

# The HTTP listener's behavior depends on whether HTTPS exists at all: if
# there's no cert, HTTP has to actually serve traffic (forward); if there is
# a cert, HTTP's only job is to bounce everything to HTTPS.
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.this.arn
  port              = 80
  protocol          = "HTTP"

  dynamic "default_action" {
    for_each = var.certificate_arn == null ? [1] : []
    content {
      type             = "forward"
      target_group_arn = aws_lb_target_group.this.arn
    }
  }

  dynamic "default_action" {
    for_each = var.certificate_arn == null ? [] : [1]
    content {
      type = "redirect"
      redirect {
        port        = "443"
        protocol    = "HTTPS"
        status_code = "HTTP_301"
      }
    }
  }
}

# Only exists at all when a certificate is provided — count-gated the same
# way as the https ingress rule above, for the same reason.
resource "aws_lb_listener" "https" {
  count             = var.certificate_arn == null ? 0 : 1
  load_balancer_arn = aws_lb.this.arn
  port              = 443
  protocol          = "HTTPS"
  certificate_arn   = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}
