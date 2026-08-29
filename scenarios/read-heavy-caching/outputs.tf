output "redis_reader_endpoint" {
  description = "Reader endpoint for the Redis replication group -- routes to a replica, for spreading read traffic off the primary."
  value       = module.redis.reader_endpoint
}
