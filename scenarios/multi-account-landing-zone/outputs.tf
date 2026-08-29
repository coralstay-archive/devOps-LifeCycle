output "ou_ids" {
  description = "Map of OU name to its Organizations OU ID, one per entry in organizational_units."
  value       = module.landing_zone.ou_ids
}
