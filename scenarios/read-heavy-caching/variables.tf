variable "name" {
  description = "Name prefix applied to the VPC and Redis replication group."
  type        = string
  default     = "read-heavy-caching"
}

variable "availability_zones" {
  description = "Availability zones to spread the VPC's subnets and Redis nodes across."
  type        = list(string)
  default     = ["ap-northeast-2a", "ap-northeast-2c"]
}
