variable "name" {
  description = "Name prefix applied to resources in both regions."
  type        = string
  default     = "multi-region-active-active"
}

variable "primary_region" {
  description = "Primary AWS region -- where the active-active pair's first VPC and its resources are provisioned."
  type        = string
  default     = "ap-northeast-2"
}

variable "secondary_region" {
  description = "Secondary AWS region -- where the active-active pair's second, independent VPC and its resources are provisioned."
  type        = string
  default     = "us-east-1"
}

variable "primary_azs" {
  description = "Availability zones to spread the primary region's VPC subnets across."
  type        = list(string)
  default     = ["ap-northeast-2a", "ap-northeast-2c"]
}

variable "secondary_azs" {
  description = "Availability zones to spread the secondary region's VPC subnets across."
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "domain_name" {
  description = "Real domain you own — no sensible default"
  type        = string
}
