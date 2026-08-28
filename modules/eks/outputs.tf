output "cluster_name" {
  description = "Name of the EKS cluster."
  value       = aws_eks_cluster.this.name
}

output "cluster_endpoint" {
  description = "API server endpoint for kubectl/the Kubernetes provider to talk to."
  value       = aws_eks_cluster.this.endpoint
}

output "cluster_certificate_authority_data" {
  description = "Base64-encoded cluster CA certificate, needed alongside cluster_endpoint to configure a Kubernetes provider/kubeconfig."
  value       = aws_eks_cluster.this.certificate_authority[0].data
}

output "node_role_arn" {
  description = "ARN of the IAM role assumed by worker nodes in the default managed node group."
  value       = aws_iam_role.node.arn
}
