variable "name" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "kms_key_arn" {
  description = "Customer-managed KMS key ARN for both the topic and queue. Leave null to use the AWS-managed alias/aws/sns and alias/aws/sqs keys."
  type        = string
  default     = null
}
