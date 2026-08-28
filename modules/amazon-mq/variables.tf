variable "name" {
  description = "Name for the broker and its security group."
  type        = string
}

variable "vpc_id" {
  description = "VPC to place the broker and its security group in."
  type        = string
}

variable "private_subnet_ids" {
  description = "Only the first subnet is used (single-instance deployment)"
  type        = list(string)
}

variable "allowed_security_group_ids" {
  description = "Security groups allowed to reach the broker on port 5671 (AMQP over TLS)."
  type        = list(string)
  default     = []
}

variable "engine_type" {
  description = "RabbitMQ or ActiveMQ — pick this only if you need protocol compatibility with an existing broker; otherwise use sns-sqs"
  type        = string
  default     = "RabbitMQ"
}

variable "engine_version" {
  description = "Broker engine version -- must be a version RabbitMQ/ActiveMQ (whichever engine_type picks) actually supports."
  type        = string
  default     = "3.13"
}

variable "host_instance_type" {
  description = "Broker instance type (e.g. mq.t3.micro) -- this module always deploys SINGLE_INSTANCE, so there's no separate replica sizing."
  type        = string
  default     = "mq.t3.micro"
}

variable "username" {
  description = "Admin username for the broker."
  type        = string
}

variable "password" {
  description = "Admin password for the broker. Must be 12-250 characters -- Amazon MQ's own API requirement, enforced by this module's precondition."
  type        = string
  sensitive   = true
}

variable "tags" {
  description = "Tags applied to the broker and its security group."
  type        = map(string)
  default     = {}
}

variable "kms_key_arn" {
  description = "Customer-managed KMS key for the broker. Defaults to null, which falls back to the AWS-owned default key."
  type        = string
  default     = null
}
