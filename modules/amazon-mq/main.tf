resource "aws_security_group" "this" {
  name        = "${var.name}-mq-sg"
  description = "Allow broker access from approved security groups"
  vpc_id      = var.vpc_id
  tags        = var.tags
}

resource "aws_vpc_security_group_ingress_rule" "amqp_tls" {
  for_each                     = toset(var.allowed_security_group_ids)
  security_group_id            = aws_security_group.this.id
  referenced_security_group_id = each.value
  from_port                    = 5671
  to_port                      = 5671
  ip_protocol                  = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "all" {
  security_group_id = aws_security_group.this.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

resource "aws_mq_broker" "this" {
  broker_name         = var.name
  engine_type         = var.engine_type
  engine_version      = var.engine_version
  host_instance_type  = var.host_instance_type
  deployment_mode     = "SINGLE_INSTANCE"
  subnet_ids          = [var.private_subnet_ids[0]]
  security_groups     = [aws_security_group.this.id]
  publicly_accessible = false

  user {
    username = var.username
    password = var.password
  }

  tags = var.tags

  lifecycle {
    precondition {
      condition     = contains(["RabbitMQ", "ActiveMQ"], var.engine_type)
      error_message = "engine_type must be RabbitMQ or ActiveMQ — Amazon MQ's only supported engines."
    }
  }
}
