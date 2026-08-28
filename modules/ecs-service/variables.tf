variable "name" {
  description = "Name used for the cluster, task definition, service, and security group."
  type        = string
}

variable "vpc_id" {
  description = "VPC to place the service's security group in."
  type        = string
}

variable "private_subnet_ids" {
  description = "Private subnet IDs the Fargate tasks run in (awsvpc networking, one ENI per task)."
  type        = list(string)
}

variable "container_image" {
  description = "Container image URI (e.g. from the ecr module's repository_url output)."
  type        = string
}

variable "container_port" {
  description = "Port the container listens on -- also what the security group ingress rules and ALB target group forward to."
  type        = number
  default     = 8080
}

variable "cpu" {
  description = "Fargate task-level vCPU units (256 = 0.25 vCPU)."
  type        = number
  default     = 256
}

variable "memory" {
  description = "Fargate task-level memory in MB."
  type        = number
  default     = 512
}

variable "desired_count" {
  description = "Number of task copies the service keeps running."
  type        = number
  default     = 2
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
  description = "Tags applied to all resources."
  type        = map(string)
  default     = {}
}
