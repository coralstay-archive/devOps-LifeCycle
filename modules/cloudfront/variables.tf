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
