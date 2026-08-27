variable "name" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "ami_id" {
  description = "Leave null to use the latest Amazon Linux 2023 AMI"
  type        = string
  default     = null
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "security_group_ids" {
  description = "Leave empty to use the VPC's default security group"
  type        = list(string)
  default     = []
}

variable "key_name" {
  description = "EC2 key pair name for SSH access. Leave null to rely on SSM Session Manager instead (recommended)."
  type        = string
  default     = null
}

variable "associate_public_ip_address" {
  type    = bool
  default = false
}

variable "iam_instance_profile" {
  description = "Instance profile name (e.g. from the iam module + an aws_iam_instance_profile)"
  type        = string
  default     = null
}

variable "user_data" {
  type    = string
  default = null
}

variable "root_volume_size" {
  description = "GB"
  type        = number
  default     = 20
}

variable "tags" {
  type    = map(string)
  default = {}
}
