variable "name" {
  description = "Base name for the VPC and the Redis replication group."
  type        = string
  default     = "session-store"
}

variable "availability_zones" {
  description = "Availability zones to spread subnets across (multi-AZ by default for spike resilience)"
  type        = list(string)
  default     = ["ap-northeast-2a", "ap-northeast-2c"]
}
