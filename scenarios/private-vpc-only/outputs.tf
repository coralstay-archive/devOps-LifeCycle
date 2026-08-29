output "vpc_id" {
  description = "VPC ID -- has no NAT gateway or internet route, only the VPC endpoints created below."
  value       = module.vpc.vpc_id
}

output "interface_endpoint_ids" {
  description = "IDs of the interface VPC endpoints (e.g. ECR, CloudWatch Logs) created to fill the gaps a NAT gateway would otherwise cover."
  value       = module.endpoints.interface_endpoint_ids
}
