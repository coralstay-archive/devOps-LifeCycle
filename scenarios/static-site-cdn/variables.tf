variable "name" {
  description = "Base name for the S3 bucket (account ID gets appended for global uniqueness) and the CloudFront distribution."
  type        = string
  default     = "static-site-cdn"
}
