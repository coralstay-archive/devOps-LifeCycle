# ElastiCache needs to know which subnets it's allowed to place cache nodes
# in — this is a separate resource from the VPC's own subnet list because
# it's ElastiCache-specific metadata, not a general networking construct.
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

# Deliberately scoped by referenced_security_group_id (an app's SG), not a
# CIDR block — Redis should never be reachable from "anywhere in the VPC,"
# only from the specific services that legitimately need it.
resource "aws_vpc_security_group_ingress_rule" "redis" {
  for_each                     = toset(var.allowed_security_group_ids)
  security_group_id            = aws_security_group.this.id
  referenced_security_group_id = each.value
  from_port                    = 6379
  to_port                      = 6379
  ip_protocol                  = "tcp"
  description                  = "Redis from an approved application security group"
}

resource "aws_vpc_security_group_egress_rule" "all" {
  security_group_id = aws_security_group.this.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
  description       = "Unrestricted egress — the replication group needs to reach AWS APIs"
}

resource "aws_elasticache_replication_group" "this" {
  replication_group_id = var.name
  description          = "${var.name} redis"
  engine               = "redis"
  node_type            = var.node_type
  num_cache_clusters   = var.num_cache_nodes

  subnet_group_name  = aws_elasticache_subnet_group.this.name
  security_group_ids = [aws_security_group.this.id]

  # Automatic failover only makes sense with a replica to fail over to — a
  # single-node "replication group" has nothing to promote if the primary
  # dies, so this only turns on when num_cache_nodes > 1.
  automatic_failover_enabled = var.num_cache_nodes > 1
  at_rest_encryption_enabled = true
  transit_encryption_enabled = true

  tags = var.tags

  # 0 or negative nodes isn't just "no replicas," it's "no cache at all" —
  # a config error, not a valid minimal deployment.
  lifecycle {
    precondition {
      condition     = var.num_cache_nodes >= 1
      error_message = "num_cache_nodes must be at least 1 (the primary node)."
    }
  }
}
