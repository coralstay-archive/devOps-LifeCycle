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
  description                  = "PostgreSQL from an approved application security group"
}

resource "aws_vpc_security_group_egress_rule" "all" {
  security_group_id = aws_security_group.this.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
  description       = "Unrestricted egress — the instance needs to reach AWS APIs (e.g. Secrets Manager for the managed password)"
}

# Enhanced Monitoring needs its own IAM role — RDS assumes it to publish OS
# metrics to CloudWatch Logs at up to 1-second granularity. Only created when
# monitoring_interval > 0, since it's meaningless (and an extra unused
# resource) otherwise.
resource "aws_iam_role" "enhanced_monitoring" {
  count = var.monitoring_interval > 0 ? 1 : 0

  name = "${var.identifier}-rds-enhanced-monitoring"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = { Service = "monitoring.rds.amazonaws.com" }
      Action    = "sts:AssumeRole"
    }]
  })

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "enhanced_monitoring" {
  count = var.monitoring_interval > 0 ? 1 : 0

  role       = aws_iam_role.enhanced_monitoring[0].name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
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

  multi_az                   = var.multi_az
  backup_retention_period    = 7
  auto_minor_version_upgrade = true

  # Both free: IAM auth just enables the capability (callers still need an
  # explicit IAM policy grant to actually use it — this alone changes
  # nothing about how the master password login works), and Performance
  # Insights' default 7-day retention has no additional charge on
  # instance classes that support it.
  iam_database_authentication_enabled = true
  performance_insights_enabled        = true
  performance_insights_kms_key_id     = var.performance_insights_kms_key_id
  enabled_cloudwatch_logs_exports     = var.log_exports
  # 0 disables enhanced monitoring entirely (RDS's own default) — no role,
  # no per-second CloudWatch charge, unless a scenario opts in.
  monitoring_interval = var.monitoring_interval
  monitoring_role_arn = var.monitoring_interval > 0 ? aws_iam_role.enhanced_monitoring[0].arn : null
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
