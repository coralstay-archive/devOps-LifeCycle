variable "aws_region" {
  description = "AWS region to deploy into"
  type        = string
  default     = "ap-northeast-2"
}

variable "name" {
  description = "Name prefix for resources in this stack"
  type        = string
  default     = "aws-launcher-example-dev"
}

variable "availability_zones" {
  description = "AZs to spread the VPC across"
  type        = list(string)
  default     = ["ap-northeast-2a", "ap-northeast-2c"]
}
