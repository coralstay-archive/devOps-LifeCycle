output "zone_id" {
  description = "Hosted zone ID -- resolves to the newly created zone or the looked-up existing zone depending on create_zone."
  value       = local.zone_id
}

output "name_servers" {
  description = "The zone's authoritative name servers, only populated when create_zone is true (null for a looked-up existing zone -- you'd already have its name servers from wherever the domain was registered)."
  value       = var.create_zone ? aws_route53_zone.this[0].name_servers : null
}
