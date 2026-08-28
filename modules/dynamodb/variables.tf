variable "table_name" {
  type = string
}

variable "hash_key" {
  type    = string
  default = "id"
}

variable "hash_key_type" {
  description = "S, N, or B"
  type        = string
  default     = "S"
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "kms_key_arn" {
  description = "Customer-managed KMS key for the table. Defaults to null, which falls back to the AWS-owned default key (aws/dynamodb)."
  type        = string
  default     = null
}
