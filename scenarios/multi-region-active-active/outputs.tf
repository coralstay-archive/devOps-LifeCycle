output "primary_vpc_id" {
  description = "VPC ID of the primary region's VPC."
  value       = module.vpc_primary.vpc_id
}

output "secondary_vpc_id" {
  description = "VPC ID of the secondary region's VPC."
  value       = module.vpc_secondary.vpc_id
}

output "zone_id" {
  description = "Route53 hosted zone ID for domain_name -- a single zone shared by both regions, since Route53 itself isn't region-scoped."
  value       = module.dns.zone_id
}
