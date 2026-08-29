variable "name" {
  description = "Base name used as the prefix/tag for the VPC, EKS cluster, Redis replication group, and Kafka cluster."
  type        = string
  default     = "high-traffic-spike"
}

variable "availability_zones" {
  description = "AZs the VPC's public/private subnets span -- needs >= 2 for the EKS/Redis/Kafka per-AZ requirements enforced by the modules this scenario composes."
  type        = list(string)
  default     = ["ap-northeast-2a", "ap-northeast-2c"]
}
