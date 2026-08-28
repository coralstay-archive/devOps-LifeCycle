output "ou_ids" {
  description = "Map of organizational unit name to its OU ID, one entry per organizational_units input"
  value       = { for k, ou in aws_organizations_organizational_unit.this : k => ou.id }
}
