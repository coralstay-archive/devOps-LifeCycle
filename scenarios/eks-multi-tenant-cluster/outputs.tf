output "cluster_endpoint" {
  description = "EKS control plane API endpoint -- used to configure kubectl/tenant access."
  value       = module.eks.cluster_endpoint
}

output "node_role_arn" {
  description = "IAM role ARN assumed by the shared worker nodes -- grant additional per-tenant permissions here if needed."
  value       = module.eks.node_role_arn
}
