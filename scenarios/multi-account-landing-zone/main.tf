# Pure pass-through to organizations-landing-zone — this scenario's whole
# value is the reminder (in its README) that this must run from the
# Organizations management account, since that constraint can't be expressed
# in Terraform itself.
module "landing_zone" {
  source               = "../../modules/organizations-landing-zone"
  organizational_units = var.organizational_units
}
