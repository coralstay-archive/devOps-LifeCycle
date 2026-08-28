variable "database_name" {
  type = string
}

variable "s3_target_path" {
  description = "e.g. s3://my-bucket/raw/"
  type        = string
}

variable "crawler_schedule" {
  description = "cron() expression. Leave null to run on-demand only."
  type        = string
  default     = null
}

variable "kms_key_arn" {
  description = "Customer-managed KMS key for the crawler's security configuration (CloudWatch logs, job bookmarks, S3 reads). Leave null to leave all three encryption modes DISABLED (Glue's own default)."
  type        = string
  default     = null
}

variable "tags" {
  type    = map(string)
  default = {}
}
