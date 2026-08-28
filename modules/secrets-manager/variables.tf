variable "name" {
  description = "Name of the Secrets Manager secret."
  type        = string
}

variable "secret_string" {
  description = "Initial secret value. Leave null to create an empty secret and fill it in outside Terraform (recommended for anything rotated)."
  type        = string
  default     = null
  sensitive   = true
}

variable "tags" {
  description = "Tags applied to the secret."
  type        = map(string)
  default     = {}
}

variable "kms_key_arn" {
  description = "Customer-managed KMS key for the secret. Defaults to null, which falls back to the AWS-managed aws/secretsmanager key."
  type        = string
  default     = null
}
