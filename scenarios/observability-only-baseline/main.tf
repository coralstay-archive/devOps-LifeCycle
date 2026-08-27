# Nothing else here on purpose — this scenario exists to stand up an alarm
# topic + dashboard independently, so a real stack's resources can be wired
# to it later without also having to redeploy the observability layer.
module "observability" {
  source      = "../../modules/observability"
  name        = var.name
  alarm_email = var.alarm_email
}
