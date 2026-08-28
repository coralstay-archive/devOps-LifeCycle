variable "name" {
  description = "Name of the WAF web ACL."
  type        = string
}

variable "scope" {
  description = "REGIONAL (for ALB/API Gateway) or CLOUDFRONT. CLOUDFRONT requires the provider to be in us-east-1."
  type        = string
  default     = "REGIONAL"
}

variable "resource_arn" {
  description = "ALB ARN to associate with (only used when scope = REGIONAL; CloudFront attaches via its own web_acl_id argument instead)"
  type        = string
  default     = null
}

variable "enable_shield_advanced" {
  description = "Requires an active Shield Advanced subscription on the account"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags applied to the web ACL."
  type        = map(string)
  default     = {}
}
