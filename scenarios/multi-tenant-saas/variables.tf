variable "name" {
  description = "Name prefix applied to the VPC, EKS cluster, and RDS instance."
  type        = string
  default     = "multi-tenant-saas"
}

variable "availability_zones" {
  description = "Availability zones to spread the VPC's subnets across."
  type        = list(string)
  default     = ["ap-northeast-2a", "ap-northeast-2c"]
}
