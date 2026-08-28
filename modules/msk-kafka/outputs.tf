output "bootstrap_brokers_tls" {
  description = "TLS bootstrap broker connection string, for wiring into a Kafka client (e.g. dms's target_kafka_broker)"
  value       = aws_msk_cluster.this.bootstrap_brokers_tls
}

output "zookeeper_connect_string" {
  description = "ZooKeeper connection string for the cluster"
  value       = aws_msk_cluster.this.zookeeper_connect_string
}

output "security_group_id" {
  description = "Security group ID guarding the brokers' TLS listener"
  value       = aws_security_group.this.id
}
