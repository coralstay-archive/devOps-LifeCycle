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
