variable "function_name" {
  description = "Name of the Lambda function"
  type        = string
}

variable "filename" {
  description = "Path to the deployment package zip"
  type        = string
}

variable "handler" {
  description = "Function entrypoint, as <file>.<exported function> for the given runtime."
  type        = string
  default     = "index.handler"
}

variable "runtime" {
  description = "Lambda runtime identifier (e.g. python3.13, nodejs20.x)."
  type        = string
  default     = "python3.13"
}

variable "memory_size" {
  description = "Memory allocated to the function in MB (128-10240, a real Lambda API range enforced by this module's precondition) -- also proportionally scales the CPU/network available to the function."
  type        = number
  default     = 128
}

variable "timeout" {
  description = "Maximum execution duration in seconds before Lambda terminates the invocation."
  type        = number
  default     = 10
}

variable "environment_variables" {
  description = "Environment variables passed to the function."
  type        = map(string)
  default     = {}
}

variable "log_retention_days" {
  description = "CloudWatch retention for the function's log group -- declared explicitly since Lambda's auto-created log group defaults to never expiring, which quietly accumulates cost forever."
  type        = number
  default     = 14
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

variable "subnet_ids" {
  description = "Private subnet IDs to attach the function to (e.g. to reach rds-postgres/elasticache-redis). Empty list (default) keeps the function off any VPC, on the Lambda service network -- attaching to a VPC is a real cold-start latency trade-off, not just a toggle, so only set this when the function actually needs to reach something private."
  type        = list(string)
  default     = []
}

variable "security_group_ids" {
  description = "Security group IDs for the function's ENIs. Only used when subnet_ids is non-empty."
  type        = list(string)
  default     = []
}

variable "code_signing_config_arn" {
  description = "ARN of an aws_signer_signing_profile-backed code signing config. Requires an AWS Signer profile set up out-of-band (this module doesn't create one) -- leave null to skip code-signing enforcement entirely."
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags applied to the function, its IAM role, and its log group"
  type        = map(string)
  default     = {}
}
