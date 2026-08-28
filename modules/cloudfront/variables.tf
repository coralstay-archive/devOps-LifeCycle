variable "name" {
  type = string
}

variable "origin_domain_name" {
  description = "e.g. an S3 bucket's bucket_regional_domain_name"
  type        = string
}

variable "certificate_arn" {
  description = "ACM certificate ARN in us-east-1. Leave null to use the default CloudFront certificate (no custom domain)."
  type        = string
  default     = null
}

variable "aliases" {
  type    = list(string)
  default = []
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "web_acl_id" {
  description = "ARN of a CLOUDFRONT-scope WAF web ACL (e.g. from modules/waf-shield) to associate with this distribution. Null means no WAF in front."
  type        = string
  default     = null
}

variable "geo_restriction_type" {
  description = "CloudFront geo restriction mode: \"none\", \"whitelist\", or \"blacklist\"."
  type        = string
  default     = "none"
}

variable "geo_restriction_locations" {
  description = "ISO 3166-1-alpha-2 country codes for geo_restriction_type whitelist/blacklist. Ignored when geo_restriction_type is \"none\"."
  type        = list(string)
  default     = []
}

variable "logging_bucket_domain_name" {
  description = "S3 bucket regional domain name to receive access logs (must already have ACLs enabled and write access granted to CloudFront's log-delivery account -- this module doesn't create/configure that bucket). Null disables access logging."
  type        = string
  default     = null
}

variable "failover_origin_domain_name" {
  description = "Domain name of a second S3 origin (e.g. bucket_regional_domain_name of a cross-region-replicated bucket) to fail over to on 403/404/5xx from the primary origin. Null (default) keeps this a single-origin distribution."
  type        = string
  default     = null
}

variable "logging_prefix" {
  description = "S3 key prefix for access logs, used only when logging_bucket_domain_name is set."
  type        = string
  default     = null
}
