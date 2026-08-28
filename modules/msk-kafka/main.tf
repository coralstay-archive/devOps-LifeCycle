resource "aws_security_group" "this" {
  name        = "${var.cluster_name}-msk-sg"
  description = "Allow Kafka broker access from approved security groups"
  vpc_id      = var.vpc_id
  tags        = var.tags
}

# Port 9094 specifically: the TLS listener. MSK also exposes a plaintext
# listener on a different port, but this module only opens the encrypted one
# (see encryption_info below) since there's no reason to allow plaintext
# broker traffic.
resource "aws_vpc_security_group_ingress_rule" "kafka_tls" {
  for_each                     = toset(var.allowed_security_group_ids)
  security_group_id            = aws_security_group.this.id
  referenced_security_group_id = each.value
  from_port                    = 9094
  to_port                      = 9094
  ip_protocol                  = "tcp"
  description                  = "Kafka TLS listener from an approved application security group"
}

resource "aws_vpc_security_group_egress_rule" "all" {
  security_group_id = aws_security_group.this.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
  description       = "Unrestricted egress — brokers need to reach AWS APIs"
}

# Broker-level logging had no destination at all before this — client/consumer
# side observability doesn't cover broker-internal events (e.g. controller
# elections, ISR shrink/expand).
resource "aws_cloudwatch_log_group" "broker" {
  name              = "/aws/msk/${var.cluster_name}"
  retention_in_days = 14
  tags              = var.tags
}

resource "aws_msk_cluster" "this" {
  cluster_name           = var.cluster_name
  kafka_version          = var.kafka_version
  number_of_broker_nodes = var.number_of_broker_nodes

  broker_node_group_info {
    instance_type   = var.broker_instance_type
    client_subnets  = var.private_subnet_ids
    security_groups = [aws_security_group.this.id]

    storage_info {
      ebs_storage_info {
        volume_size = var.broker_volume_size
      }
    }
  }

  # client_broker = "TLS" rejects plaintext connections outright;
  # in_cluster = true also encrypts inter-broker replication traffic, not
  # just client-facing traffic.
  encryption_info {
    encryption_in_transit {
      client_broker = "TLS"
      in_cluster    = true
    }
    encryption_at_rest_kms_key_arn = var.encryption_at_rest_kms_key_arn
  }

  logging_info {
    broker_logs {
      cloudwatch_logs {
        enabled   = true
        log_group = aws_cloudwatch_log_group.broker.name
      }
    }
  }

  tags = var.tags

  # This isn't a style preference — MSK's API itself rejects a broker count
  # that isn't a clean multiple of the subnet (AZ) count, because it can't
  # spread brokers evenly across AZs otherwise. Catching it here beats
  # waiting for the apply to fail deep into cluster creation.
  lifecycle {
    precondition {
      condition     = var.number_of_broker_nodes % length(var.private_subnet_ids) == 0
      error_message = "number_of_broker_nodes must be a multiple of the number of subnets (AZs) — this is an MSK API requirement, not just a style preference."
    }
  }
}
