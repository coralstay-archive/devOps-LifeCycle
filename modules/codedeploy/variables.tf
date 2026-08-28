variable "name" {
  description = "Base name for the CodeDeploy application, deployment group, and IAM role."
  type        = string
}

variable "ecs_cluster_name" {
  description = "Name of the ECS cluster running the service being blue/green deployed."
  type        = string
}

variable "ecs_service_name" {
  description = "Name of the ECS service CodeDeploy manages traffic shifting for."
  type        = string
}

variable "prod_listener_arn" {
  description = "ARN of the ALB listener CodeDeploy shifts production traffic through between the blue and green target groups."
  type        = string
}

variable "target_group_blue_name" {
  description = "Name of the blue (currently live) target group. Must differ from target_group_green_name -- enforced by a precondition."
  type        = string
}

variable "target_group_green_name" {
  description = "Name of the green (newly deployed) target group. Must differ from target_group_blue_name -- enforced by a precondition."
  type        = string
}

variable "tags" {
  description = "Tags applied to the CodeDeploy IAM role."
  type        = map(string)
  default     = {}
}
