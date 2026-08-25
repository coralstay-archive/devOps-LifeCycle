module "landing_zone" {
  source               = "../../modules/organizations-landing-zone"
  organizational_units = var.organizational_units
}
