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
}

resource "aws_vpc_security_group_egress_rule" "all" {
  security_group_id = aws_security_group.this.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

resource "aws_redshift_cluster" "this" {
  cluster_identifier        = var.cluster_identifier
  node_type                 = var.node_type
  cluster_type              = "single-node"
  database_name             = var.database_name
  master_username           = var.master_username
  manage_master_password    = true
  cluster_subnet_group_name = aws_redshift_subnet_group.this.name
  vpc_security_group_ids    = [aws_security_group.this.id]
  encrypted                 = true
  skip_final_snapshot       = var.skip_final_snapshot
  final_snapshot_identifier = var.skip_final_snapshot ? null : "${var.cluster_identifier}-final"

  tags = var.tags
}
