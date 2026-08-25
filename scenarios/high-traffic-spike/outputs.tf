output "eks_cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "redis_primary_endpoint" {
  value = module.redis.primary_endpoint
}

output "kafka_bootstrap_brokers_tls" {
  value = module.kafka.bootstrap_brokers_tls
}
