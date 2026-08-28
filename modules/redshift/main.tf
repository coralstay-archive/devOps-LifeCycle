resource "aws_redshift_subnet_group" "this" {
  name       = "${var.cluster_identifier}-subnet-group"
  subnet_ids = var.private_subnet_ids
  tags       = var.tags
}

resource "aws_security_group" "this" {
  name        = "${var.cluster_identifier}-redshift-sg"
  description = "Allow Redshift access from approved security groups"
  vpc_id      = var.vpc_id
  tags        = var.tags
}

resource "aws_vpc_security_group_ingress_rule" "redshift" {
  for_each                     = toset(var.allowed_security_group_ids)
  security_group_id            = aws_security_group.this.id
  referenced_security_group_id = each.value
  from_port                    = 5439
  to_port                      = 5439
  ip_protocol                  = "tcp"
  description                  = "Redshift from an approved application security group"
}

resource "aws_vpc_security_group_egress_rule" "all" {
  security_group_id = aws_security_group.this.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
  description       = "Unrestricted egress — the cluster needs to reach AWS APIs (e.g. S3 for COPY/UNLOAD)"
}

resource "aws_redshift_cluster" "this" {
  cluster_identifier = var.cluster_identifier
  node_type          = var.node_type
  # single-node hardcoded deliberately: it's the cheapest way to get a
  # working Redshift cluster for this minimal module. Bump to multi-node
  # (and expose number_of_nodes) once real data volume needs it.
  cluster_type    = "single-node"
  database_name   = var.database_name
  master_username = var.master_username
  # Same pattern as rds-postgres: let AWS manage the master password via
  # Secrets Manager instead of ever holding it as a plain Terraform value.
  manage_master_password    = true
  cluster_subnet_group_name = aws_redshift_subnet_group.this.name
  vpc_security_group_ids    = [aws_security_group.this.id]
  encrypted                 = true
  # kms_key_id defaults to null, which makes AWS fall back to the
  # AWS-managed aws/redshift key — same "encrypted either way, this is just
  # about who manages the key" pattern used elsewhere in this repo.
  kms_key_id = var.kms_key_arn
  # Redshift's actual default is TRUE if left unset — unlike RDS, which
  # defaults to false in a VPC. This isn't a style preference: an unset
  # publicly_accessible here would put the cluster on a public IP despite
  # already being scoped to private subnets and a locked-down security group.
  publicly_accessible       = false
  enhanced_vpc_routing      = var.enhanced_vpc_routing
  skip_final_snapshot       = var.skip_final_snapshot
  final_snapshot_identifier = var.skip_final_snapshot ? null : "${var.cluster_identifier}-final"

  dynamic "logging" {
    for_each = var.logging_bucket_name == null ? [] : [1]
    content {
      enable        = true
      bucket_name   = var.logging_bucket_name
      s3_key_prefix = var.logging_s3_key_prefix
    }
  }

  tags = var.tags

  # Redshift's database naming rule: must start with a lowercase letter,
  # lowercase alphanumeric/underscore after that — catches the same class of
  # naming mistake the glue module's precondition catches for Glue.
  lifecycle {
    precondition {
      condition     = can(regex("^[a-z][a-z0-9_]*$", var.database_name))
      error_message = "database_name must start with a lowercase letter and contain only lowercase alphanumerics/underscore — Redshift's database naming rule."
    }
  }
}
