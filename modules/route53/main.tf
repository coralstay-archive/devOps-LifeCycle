# Two mutually exclusive paths depending on create_zone: either this module
# owns the zone's lifecycle, or it just needs to look up a zone someone else
# already created (e.g. bought the domain, zone exists, you just want to add
# records to it).
resource "aws_route53_zone" "this" {
  count = var.create_zone ? 1 : 0
  name  = var.domain_name
}

data "aws_route53_zone" "existing" {
  count = var.create_zone ? 0 : 1
  name  = var.domain_name
}

# Collapses the two conditional resources above into one value the rest of
# this module (and its outputs) can reference without caring which branch
# was taken.
locals {
  zone_id = var.create_zone ? aws_route53_zone.this[0].zone_id : data.aws_route53_zone.existing[0].zone_id
}

# Generic record factory: var.records is a map so callers can declare
# however many A/CNAME/etc. records they need without this module having
# to know about each one individually.
resource "aws_route53_record" "this" {
  for_each = var.records

  zone_id = local.zone_id
  name    = each.key
  type    = each.value.type
  ttl     = each.value.ttl
  records = each.value.values

  # A TTL of 0 or negative isn't meaningful — it'd either be rejected by the
  # API or behave unpredictably, so this is a config-time sanity check
  # rather than relying on that behavior.
  lifecycle {
    precondition {
      condition     = each.value.ttl > 0
      error_message = "Record \"${each.key}\" has ttl <= 0 — TTL must be a positive number of seconds."
    }
  }
}
