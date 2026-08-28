resource "aws_security_group" "this" {
  name        = "${var.name}-mq-sg"
  description = "Allow broker access from approved security groups"
  vpc_id      = var.vpc_id
  tags        = var.tags
}

# Port 5671 = AMQP over TLS. Scoped to specific app security groups, same
# pattern as every other datastore module in this repo (rds-postgres,
# elasticache-redis, msk-kafka) — never opened to a CIDR range.
resource "aws_vpc_security_group_ingress_rule" "amqp_tls" {
  for_each                     = toset(var.allowed_security_group_ids)
  security_group_id            = aws_security_group.this.id
  referenced_security_group_id = each.value
  from_port                    = 5671
  to_port                      = 5671
  ip_protocol                  = "tcp"
  description                  = "AMQP over TLS from an approved application security group"
}

resource "aws_vpc_security_group_egress_rule" "all" {
  security_group_id = aws_security_group.this.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
  description       = "Unrestricted egress — the broker needs to reach AWS APIs/NAT; scoping this down isn't worth the maintenance cost for a minimal module"
}

# SINGLE_INSTANCE deployment (no HA) — see this module's README for when
# you'd actually reach for this instead of sns-sqs (short version: only for
# AMQP/MQTT/STOMP protocol compatibility with something pre-existing).
resource "aws_mq_broker" "this" {
  broker_name                = var.name
  engine_type                = var.engine_type
  engine_version             = var.engine_version
  host_instance_type         = var.host_instance_type
  deployment_mode            = "SINGLE_INSTANCE"
  subnet_ids                 = [var.private_subnet_ids[0]]
  security_groups            = [aws_security_group.this.id]
  publicly_accessible        = false
  auto_minor_version_upgrade = true

  user {
    username = var.username
    password = var.password
  }

  tags = var.tags

  # RabbitMQ and ActiveMQ are the only two engines Amazon MQ supports —
  # anything else would be rejected by the API.
  lifecycle {
    precondition {
      condition     = contains(["RabbitMQ", "ActiveMQ"], var.engine_type)
      error_message = "engine_type must be RabbitMQ or ActiveMQ — Amazon MQ's only supported engines."
    }

    # Amazon MQ's own API requirement, not a style preference — a shorter
    # password fails at broker-creation time with a less specific error.
    precondition {
      condition     = length(var.password) >= 12 && length(var.password) <= 250
      error_message = "password must be 12-250 characters — Amazon MQ's API requirement."
    }
  }
}
