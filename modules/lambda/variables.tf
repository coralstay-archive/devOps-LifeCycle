variable "function_name" {
  type = string
}

variable "filename" {
  description = "Path to the deployment package zip"
  type        = string
}

variable "handler" {
  type    = string
  default = "index.handler"
}

variable "runtime" {
  type    = string
  default = "python3.13"
}

variable "memory_size" {
  type    = number
  default = 128
}

variable "timeout" {
  type    = number
  default = 10
}

variable "environment_variables" {
  type    = map(string)
  default = {}
}

variable "log_retention_days" {
  type    = number
  default = 14
}

variable "log_kms_key_arn" {
  description = "Customer-managed KMS key for the function's log group. Defaults to null, which uses CloudWatch Logs' default encryption."
  type        = string
  default     = null
}

variable "dead_letter_target_arn" {
  description = "SNS topic or SQS queue ARN to send failed async invocations to. Leave null to just retry/drop them."
  type        = string
  default     = null
}

variable "reserved_concurrent_executions" {
  description = "Ceiling on concurrent executions for this function. Leave null for unreserved (Lambda's default — bounded only by the account-level limit)."
  type        = number
  default     = null
}

variable "kms_key_arn" {
  description = "Customer-managed KMS key to encrypt environment variables with. Defaults to null, which uses Lambda's AWS-managed key."
  type        = string
  default     = null
}

variable "tags" {
  type    = map(string)
  default = {}
}
