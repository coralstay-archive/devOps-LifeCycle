# DNS validation (not email validation): AWS gives you a CNAME record to
# create as proof you control the domain. create_before_destroy matters here
# specifically — replacing a cert in place (destroy then create) would leave
# a window with no valid cert at all for anything already using it.
resource "aws_acm_certificate" "this" {
  domain_name               = var.domain_name
  subject_alternative_names = var.subject_alternative_names
  validation_method         = "DNS"

  lifecycle {
    create_before_destroy = true

    # Listing the primary domain again in subject_alternative_names doesn't
    # break anything technically, it's just redundant — domain_name is
    # already covered. Catching it here saves a confusing "why does this SAN
    # list have my main domain in it" moment later.
    precondition {
      condition     = !contains(var.subject_alternative_names, var.domain_name)
      error_message = "subject_alternative_names should not repeat domain_name — it's already covered as the primary name."
    }
  }
}

# For each domain covered by the cert (primary + SANs), ACM tells us exactly
# what DNS record to create to prove ownership — this for_each turns that
# list into actual Route53 records, one per domain.
resource "aws_route53_record" "validation" {
  for_each = {
    for dvo in aws_acm_certificate.this.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      type   = dvo.resource_record_type
      record = dvo.resource_record_value
    }
  }

  zone_id         = var.zone_id
  name            = each.value.name
  type            = each.value.type
  ttl             = 60
  records         = [each.value.record]
  allow_overwrite = true
}

# This is what actually blocks until ACM sees the validation records and
# marks the cert issued — without it, downstream resources (ALB listeners,
# CloudFront) could try to reference a cert that's still pending.
resource "aws_acm_certificate_validation" "this" {
  certificate_arn         = aws_acm_certificate.this.arn
  validation_record_fqdns = [for r in aws_route53_record.validation : r.fqdn]
}
