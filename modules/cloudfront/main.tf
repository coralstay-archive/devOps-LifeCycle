# OAC (Origin Access Control), not the older OAI (Origin Access Identity) —
# OAC is AWS's current recommended way to let CloudFront read a private S3
# bucket without making the bucket itself public. Signing every request
# (signing_behavior = "always") with SigV4 is what proves to S3 the request
# actually came from this distribution.
resource "aws_cloudfront_origin_access_control" "this" {
  name                              = var.name
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_distribution" "this" {
  enabled         = true
  is_ipv6_enabled = true
  aliases         = var.aliases
  tags            = var.tags

  # This module always fronts an S3 origin via OAC (see origin_access_control
  # above) — it's a static-site distribution, so a request for "/" needs a
  # real object to resolve to.
  default_root_object = "index.html"

  # Points at the S3 origin and attaches the OAC above — without
  # origin_access_control_id here, CloudFront would need the bucket to be
  # public (or use the deprecated OAI) to read from it.
  origin {
    domain_name              = var.origin_domain_name
    origin_id                = var.name
    origin_access_control_id = aws_cloudfront_origin_access_control.this.id
  }

  # GET/HEAD only, cookies/query strings not forwarded — appropriate for
  # static content where every visitor gets the same response for the same
  # URL, which is the point of caching in the first place.
  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = var.name
    viewer_protocol_policy = "redirect-to-https"

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  # Falls back to CloudFront's own shared default certificate (no custom
  # domain support) when no ACM cert is supplied — otherwise uses the given
  # cert with SNI, which is what lets one CloudFront edge server host many
  # distributions' certs cheaply.
  viewer_certificate {
    cloudfront_default_certificate = var.certificate_arn == null
    acm_certificate_arn            = var.certificate_arn
    ssl_support_method             = var.certificate_arn == null ? null : "sni-only"
    # Only settable with a custom cert (sni-only) — the default CloudFront
    # certificate path is pinned to TLSv1 for legacy-client compatibility
    # and can't be overridden.
    minimum_protocol_version = var.certificate_arn == null ? null : "TLSv1.2_2021"
  }

  # A custom certificate with no aliases to serve it on is a contradiction —
  # the cert exists to cover a custom domain, and aliases is what actually
  # tells CloudFront which custom domain(s) to answer for.
  lifecycle {
    precondition {
      condition     = var.certificate_arn == null || length(var.aliases) > 0
      error_message = "Setting certificate_arn without any aliases makes no sense — a custom cert with no custom domain to serve it on."
    }
  }
}
