output "ou_ids" {
  value = { for k, ou in aws_organizations_organizational_unit.this : k => ou.id }
}
