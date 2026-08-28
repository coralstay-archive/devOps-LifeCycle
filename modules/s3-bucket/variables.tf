variable "bucket_name" {
  description = "Globally unique S3 bucket name"
  type        = string
}

variable "versioning_enabled" {
  description = "Enable object versioning (required for safe Terraform state buckets)"
  type        = bool
  default     = true
}

variable "force_destroy" {
  description = "Allow bucket deletion even if it still contains objects (keep false for anything holding real data)"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags applied to the bucket"
  type        = map(string)
  default     = {}
}

variable "kms_key_arn" {
  description = "Customer-managed KMS key ARN for bucket encryption. Leave null to use SSE-S3 (AES256, current default)."
  type        = string
  default     = null
}
