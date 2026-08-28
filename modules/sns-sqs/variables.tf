variable "name" {
  description = "Base name for the SNS topic and SQS queue (suffixed with -topic/-queue)."
  type        = string
}

variable "tags" {
  description = "Tags applied to the topic and queue."
  type        = map(string)
  default     = {}
}

variable "kms_key_arn" {
  description = "Customer-managed KMS key ARN for both the topic and queue. Leave null to use the AWS-managed alias/aws/sns and alias/aws/sqs keys."
  type        = string
  default     = null
}
