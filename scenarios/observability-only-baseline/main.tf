module "observability" {
  source      = "../../modules/observability"
  name        = var.name
  alarm_email = var.alarm_email
}
