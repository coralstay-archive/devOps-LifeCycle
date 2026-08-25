variable "name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "private_subnet_ids" {
  description = "Only the first subnet is used (single-instance deployment)"
  type        = list(string)
}

variable "allowed_security_group_ids" {
  type    = list(string)
  default = []
}

variable "engine_type" {
  description = "RabbitMQ or ActiveMQ — pick this only if you need protocol compatibility with an existing broker; otherwise use sns-sqs"
  type        = string
  default     = "RabbitMQ"
}

variable "engine_version" {
  type    = string
  default = "3.13"
}

variable "host_instance_type" {
  type    = string
  default = "mq.t3.micro"
}

variable "username" {
  type = string
}

variable "password" {
  type      = string
  sensitive = true
}

variable "tags" {
  type    = map(string)
  default = {}
}
