data "aws_organizations_organization" "current" {
  lifecycle {
    precondition {
      condition     = length(var.organizational_units) > 0
      error_message = "organizational_units must not be empty — this module exists to create OUs, not just read the org."
    }
  }
}

resource "aws_organizations_organizational_unit" "this" {
  for_each  = toset(var.organizational_units)
  name      = each.value
  parent_id = data.aws_organizations_organization.current.roots[0].id

  tags = var.tags
}
