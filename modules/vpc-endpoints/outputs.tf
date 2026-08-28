output "interface_endpoint_ids" {
  description = "Map of interface_services entry -> its aws_vpc_endpoint ID (e.g. { \"ecr.api\" = \"vpce-...\" })."
  value       = { for k, e in aws_vpc_endpoint.interface : k => e.id }
}

output "security_group_id" {
  description = "Security group attached to all interface endpoints -- reference this if another resource needs to be added as an allowed source beyond the VPC CIDR."
  value       = aws_security_group.interface_endpoints.id
}
