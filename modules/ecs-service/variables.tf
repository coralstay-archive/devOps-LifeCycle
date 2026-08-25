variable "name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "container_image" {
  type = string
}

variable "container_port" {
  type    = number
  default = 8080
}

variable "cpu" {
  type    = number
  default = 256
}

variable "memory" {
  type    = number
  default = 512
}

variable "desired_count" {
  type    = number
  default = 2
}

variable "target_group_arn" {
  description = "ALB target group ARN to attach the service to. Leave null to run without a load balancer."
  type        = string
  default     = null
}

variable "tags" {
  type    = map(string)
  default = {}
}
