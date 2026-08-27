# RDS needs to know which subnets are candidates for placing DB instances —
# needs >= 2 AZs represented for Multi-AZ failover to actually have
# somewhere to fail over to.
resource "aws_db_subnet_group" "this" {
  name       = "${var.identifier}-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = var.tags
}

resource "aws_security_group" "this" {
  name        = "${var.identifier}-rds-sg"
  description = "Allow Postgres access from approved security groups"
  vpc_id      = var.vpc_id

  tags = var.tags
}

# Scoped to specific app security groups (allowed_security_group_ids), not a
# CIDR range — a database should never be reachable just by virtue of being
# "in the VPC."
resource "aws_vpc_security_group_ingress_rule" "postgres" {
  for_each = toset(var.allowed_security_group_ids)

  security_group_id            = aws_security_group.this.id
  referenced_security_group_id = each.value
  from_port                    = 5432
  to_port                      = 5432
  ip_protocol                  = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "all" {
  security_group_id = aws_security_group.this.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

resource "aws_db_instance" "this" {
  identifier     = var.identifier
  engine         = "postgres"
  engine_version = var.engine_version
  instance_class = var.instance_class

  allocated_storage      = var.allocated_storage
  storage_encrypted      = true
  db_subnet_group_name   = aws_db_subnet_group.this.name
  vpc_security_group_ids = [aws_security_group.this.id]

  db_name  = var.database_name
  username = var.master_username
  # AWS-native Secrets Manager integration: no password variable needed,
  # avoids ever putting a DB password in state/plan output directly.
  manage_master_user_password = true

  multi_az                = var.multi_az
  backup_retention_period = 7
  # deletion_protection tracks skip_final_snapshot's inverse deliberately:
  # if you've said "it's fine to skip the final snapshot," you've already
  # accepted losing this data, so there's no reason deletion_protection
  # should still be blocking you.
  deletion_protection       = !var.skip_final_snapshot
  skip_final_snapshot       = var.skip_final_snapshot
  final_snapshot_identifier = var.skip_final_snapshot ? null : "${var.identifier}-final"

  tags = var.tags

  # RDS's actual minimum for gp2/gp3 storage on PostgreSQL — below this the
  # API itself would reject the request.
  lifecycle {
    precondition {
      condition     = var.allocated_storage >= 20
      error_message = "allocated_storage must be at least 20 GB — RDS's minimum for gp2/gp3 storage on PostgreSQL."
    }
  }
}
