variable "name" {
  description = "Name prefix applied to the VPC and its endpoints."
  type        = string
  default     = "private-vpc-only"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC -- also passed to modules/vpc-endpoints so its endpoint security group can scope ingress to this range."
  type        = string
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "Availability zones to spread the VPC's subnets across."
  type        = list(string)
  default     = ["ap-northeast-2a", "ap-northeast-2c"]
}

variable "region" {
  description = "AWS region, used to build each VPC endpoint's service_name (e.g. com.amazonaws.<region>.s3)."
  type        = string
  default     = "ap-northeast-2"
}
