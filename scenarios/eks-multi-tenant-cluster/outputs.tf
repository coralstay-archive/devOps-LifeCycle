output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "node_role_arn" {
  value = module.eks.node_role_arn
}
