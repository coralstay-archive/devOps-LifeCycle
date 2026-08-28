variable "table_name" {
  description = "Name of the DynamoDB table."
  type        = string
}

variable "hash_key" {
  description = "Name of the table's hash (partition) key attribute."
  type        = string
  default     = "id"
}

variable "hash_key_type" {
  description = "S, N, or B"
  type        = string
  default     = "S"
}

variable "tags" {
  description = "Tags applied to the table."
  type        = map(string)
  default     = {}
}

variable "kms_key_arn" {
  description = "Customer-managed KMS key for the table. Defaults to null, which falls back to the AWS-owned default key (aws/dynamodb)."
  type        = string
  default     = null
}
