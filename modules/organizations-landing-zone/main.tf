data "aws_organizations_organization" "current" {}

resource "aws_organizations_organizational_unit" "this" {
  for_each  = toset(var.organizational_units)
  name      = each.value
  parent_id = data.aws_organizations_organization.current.roots[0].id

  tags = var.tags
}
