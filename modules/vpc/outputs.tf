output "vpc_id" {
  description = "ID of the created VPC"
  value       = aws_vpc.this.id
}

output "public_subnet_ids" {
  description = "IDs of public subnets, one per AZ"
  value       = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "IDs of private subnets, one per AZ"
  value       = aws_subnet.private[*].id
}

output "private_route_table_ids" {
  description = "Route table IDs backing the private subnets (for VPC gateway endpoints)"
  value       = aws_route_table.private[*].id
}
