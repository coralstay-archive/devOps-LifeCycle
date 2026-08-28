variable "name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "public_subnet_ids" {
  type = list(string)
}

variable "target_port" {
  type    = number
  default = 8080
}

variable "health_check_path" {
  type    = string
  default = "/"
}

variable "certificate_arn" {
  description = "ACM certificate ARN. If set, adds an HTTPS listener and redirects HTTP to it. If null, HTTP forwards directly."
  type        = string
  default     = null
}

variable "enable_deletion_protection" {
  description = "Blocks accidental/automated deletion of the load balancer. Off by default so terraform destroy works cleanly for a scaffold/demo stack — flip on for anything real."
  type        = bool
  default     = false
}

variable "tags" {
  type    = map(string)
  default = {}
}
