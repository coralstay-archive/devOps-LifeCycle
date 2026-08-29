output "bootstrap_brokers_tls" {
  description = "TLS bootstrap broker connection string producers/consumers use to connect to the MSK cluster."
  value       = module.kafka.bootstrap_brokers_tls
}
