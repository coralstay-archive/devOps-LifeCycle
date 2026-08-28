variable "database_name" {
  description = "Name of the Glue catalog database. Lowercase alphanumeric/underscore only -- Glue's naming rule doesn't allow hyphens, unlike most AWS resource names."
  type        = string
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
  description = "Tags applied to the crawler and its IAM role."
  type        = map(string)
  default     = {}
}
