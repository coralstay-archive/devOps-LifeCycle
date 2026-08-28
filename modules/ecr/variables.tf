variable "name" {
  description = "Repository name"
  type        = string
}

variable "untagged_image_expiry_days" {
  type    = number
  default = 14
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "kms_key_arn" {
  description = "Customer-managed KMS key for image encryption. Defaults to null, which uses AES256 (Amazon S3-managed) encryption instead."
  type        = string
  default     = null
}
