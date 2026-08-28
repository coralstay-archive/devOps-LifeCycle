output "primary_endpoint" {
  description = "Endpoint address for read/write connections (the primary node)."
  value       = aws_elasticache_replication_group.this.primary_endpoint_address
}

output "reader_endpoint" {
  description = "Endpoint address for read-only connections, load-balanced across replicas."
  value       = aws_elasticache_replication_group.this.reader_endpoint_address
}

output "security_group_id" {
  description = "Security group ID attached to the replication group."
  value       = aws_security_group.this.id
}
