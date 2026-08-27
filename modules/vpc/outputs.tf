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

  # Runtime invariant, not just a test assertion: if this ever drifts (e.g. a
  # future refactor breaks the count math), every module that fans private
  # subnets out per-AZ (rds-postgres, msk-kafka, etc.) would silently get the
  # wrong topology. Catching it here, at the source, fails loudly instead.
  precondition {
    condition     = length(aws_subnet.private) == length(var.availability_zones)
    error_message = "Expected exactly one private subnet per availability zone."
  }
}

output "private_route_table_ids" {
  description = "Route table IDs backing the private subnets (for VPC gateway endpoints)"
  value       = aws_route_table.private[*].id
}
