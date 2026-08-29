variable "name" {
  description = "Base name used as the prefix for the VPC and as the EKS cluster_name."
  type        = string
  default     = "eks-multi-tenant-cluster"
}

variable "availability_zones" {
  description = "AZs the VPC's public/private subnets span -- needs >= 2 for the ALB/NAT gateway/EKS per-AZ requirements enforced by the modules this scenario composes."
  type        = list(string)
  default     = ["ap-northeast-2a", "ap-northeast-2c"]
}
