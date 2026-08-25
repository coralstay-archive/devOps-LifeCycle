resource "aws_route53_zone" "this" {
  count = var.create_zone ? 1 : 0
  name  = var.domain_name
}

data "aws_route53_zone" "existing" {
  count = var.create_zone ? 0 : 1
  name  = var.domain_name
}

locals {
  zone_id = var.create_zone ? aws_route53_zone.this[0].zone_id : data.aws_route53_zone.existing[0].zone_id
}

resource "aws_route53_record" "this" {
  for_each = var.records

  zone_id = local.zone_id
  name    = each.key
  type    = each.value.type
  ttl     = each.value.ttl
  records = each.value.values
}
