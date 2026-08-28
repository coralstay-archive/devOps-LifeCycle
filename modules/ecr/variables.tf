variable "name" {
  description = "Repository name"
  type        = string
}

variable "untagged_image_expiry_days" {
  description = "Days an untagged image is kept before the lifecycle policy expires it. IMMUTABLE tags mean untagged images accumulate on every rebuild without a new tag, so this needs to be a real positive number."
  type        = number
  default     = 14
}

variable "tags" {
  description = "Tags applied to the repository."
  type        = map(string)
  default     = {}
}

variable "kms_key_arn" {
  description = "Customer-managed KMS key for image encryption. Defaults to null, which uses AES256 (Amazon S3-managed) encryption instead."
  type        = string
  default     = null
}
