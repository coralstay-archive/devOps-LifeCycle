output "redis_primary_endpoint" {
  description = "Primary endpoint (read/write) of the Redis replication group backing session storage."
  value       = module.redis.primary_endpoint
}
