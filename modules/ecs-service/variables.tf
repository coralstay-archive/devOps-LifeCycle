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

variable "alb_security_group_id" {
  description = "ALB's security group ID (the alb module's security_group_id output). If set, container_port ingress is scoped to only the ALB instead of 0.0.0.0/0. Leave null if there's no ALB in front of this service."
  type        = string
  default     = null
}

variable "enable_container_insights" {
  description = "Per-container CPU/memory metrics beyond task-level. Real per-cluster cost when enabled."
  type        = bool
  default     = false
}

variable "tags" {
  type    = map(string)
  default = {}
}
