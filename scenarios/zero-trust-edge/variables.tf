variable "name" {
  description = "Base name for the VPC, ALB, and the WAF web ACL protecting it."
  type        = string
  default     = "zero-trust-edge"
}

variable "availability_zones" {
  description = "Availability zones to spread subnets across (multi-AZ by default for spike resilience)"
  type        = list(string)
  default     = ["ap-northeast-2a", "ap-northeast-2c"]
}
