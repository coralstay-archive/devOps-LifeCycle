# Must be run from the Organizations management account — this data source
# is how the module discovers the org's root ID, which every top-level OU
# needs as its parent.
data "aws_organizations_organization" "current" {
  # Guards against calling this module with an empty OU list, which would
  # silently do nothing useful (zero resources created) since the
  # for_each below would just have nothing to iterate. Checking here (a
  # resource that's *always* created) instead of on the for_each resource
  # itself, because a precondition on a for_each with zero instances never
  # actually runs — there's no instance to run it on.
  lifecycle {
    precondition {
      condition     = length(var.organizational_units) > 0
      error_message = "organizational_units must not be empty — this module exists to create OUs, not just read the org."
    }
  }
}

# One OU per entry in var.organizational_units, all created directly under
# the org root (not nested under each other) — deliberately flat/minimal.
# See this module's README for what's NOT here yet (SCPs, Control Tower).
resource "aws_organizations_organizational_unit" "this" {
  for_each  = toset(var.organizational_units)
  name      = each.value
  parent_id = data.aws_organizations_organization.current.roots[0].id

  tags = var.tags
}
