output "eks_cluster_endpoint" {
  description = "EKS cluster API endpoint tenant workloads run against."
  value       = module.eks.cluster_endpoint
}

output "rds_endpoint" {
  description = "Connection endpoint (host:port) for the shared RDS Postgres instance."
  value       = module.rds.endpoint
}
