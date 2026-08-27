variable "aws_region" {
  description = "AWS region for the state bucket and lock table"
  type        = string
  default     = "ap-northeast-2"
}

variable "state_bucket_name" {
  description = "Globally unique name for the Terraform remote state bucket"
  type        = string
}
