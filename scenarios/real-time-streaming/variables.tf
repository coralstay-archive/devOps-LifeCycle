variable "name" {
  description = "Name prefix applied to the VPC and MSK cluster."
  type        = string
  default     = "real-time-streaming"
}

variable "availability_zones" {
  description = "Availability zones to spread the VPC's subnets and MSK brokers across."
  type        = list(string)
  default     = ["ap-northeast-2a", "ap-northeast-2c"]
}
