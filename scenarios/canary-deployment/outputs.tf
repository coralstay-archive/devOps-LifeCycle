output "cluster_endpoint" {
  description = "EKS API server endpoint -- the base platform a canary traffic-shifting tool (Argo Rollouts/App Mesh) would run on top of."
  value       = module.eks.cluster_endpoint
}
