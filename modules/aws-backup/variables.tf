variable "name" {
  description = "Base name used for the backup vault, plan, selection, and IAM role."
  type        = string
}

variable "schedule" {
  description = "Cron expression, default daily at 05:00 UTC"
  type        = string
  default     = "cron(0 5 * * ? *)"
}

variable "retention_days" {
  description = "How long backups from the daily rule are kept before deletion. Must be at least 1 -- enforced by a precondition."
  type        = number
  default     = 35
}

variable "resource_arns" {
  description = "ARNs to back up"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Tags applied to the vault, plan, and IAM role."
  type        = map(string)
  default     = {}
}

variable "kms_key_arn" {
  description = "Customer-managed KMS key for the backup vault. Defaults to null, which falls back to the AWS-managed aws/backup key."
  type        = string
  default     = null
}
