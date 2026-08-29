output "eks_cluster_endpoint" {
  description = "EKS control plane API endpoint -- used to configure kubectl access."
  value       = module.eks.cluster_endpoint
}

output "redis_primary_endpoint" {
  description = "ElastiCache Redis primary node endpoint for read/write traffic."
  value       = module.redis.primary_endpoint
}

output "kafka_bootstrap_brokers_tls" {
  description = "MSK bootstrap broker list (TLS listener) for Kafka clients to connect with."
  value       = module.kafka.bootstrap_brokers_tls
}
