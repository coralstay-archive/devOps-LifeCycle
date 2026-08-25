resource "aws_elasticache_subnet_group" "this" {
  name       = "${var.name}-subnet-group"
  subnet_ids = var.private_subnet_ids
}

resource "aws_security_group" "this" {
  name        = "${var.name}-redis-sg"
  description = "Allow Redis access from approved security groups"
  vpc_id      = var.vpc_id
  tags        = var.tags
}

resource "aws_vpc_security_group_ingress_rule" "redis" {
  for_each                     = toset(var.allowed_security_group_ids)
  security_group_id            = aws_security_group.this.id
  referenced_security_group_id = each.value
  from_port                    = 6379
  to_port                      = 6379
  ip_protocol                  = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "all" {
  security_group_id = aws_security_group.this.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

resource "aws_elasticache_replication_group" "this" {
  replication_group_id = var.name
  description          = "${var.name} redis"
  engine               = "redis"
  node_type            = var.node_type
  num_cache_clusters   = var.num_cache_nodes

  subnet_group_name  = aws_elasticache_subnet_group.this.name
  security_group_ids = [aws_security_group.this.id]

  automatic_failover_enabled = var.num_cache_nodes > 1
  at_rest_encryption_enabled = true
  transit_encryption_enabled = true

  tags = var.tags
}
