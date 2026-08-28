variable "name" {
  description = "Name tag for the instance."
  type        = string
}

variable "subnet_id" {
  description = "Subnet to launch the instance into."
  type        = string
}

variable "ami_id" {
  description = "Leave null to use the latest Amazon Linux 2023 AMI"
  type        = string
  default     = null
}

variable "instance_type" {
  description = "EC2 instance type."
  type        = string
  default     = "t3.micro"
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
  description = "Assign a public IP on launch. Only meaningful in a public subnet -- keep false for anything in a private subnet."
  type        = bool
  default     = false
}

variable "iam_instance_profile" {
  description = "Instance profile name (e.g. from the iam module + an aws_iam_instance_profile)"
  type        = string
  default     = null
}

variable "user_data" {
  description = "Shell script or cloud-init data to run on first boot. Leave null to skip."
  type        = string
  default     = null
}

variable "root_volume_size" {
  description = "GB"
  type        = number
  default     = 20
}

variable "enable_detailed_monitoring" {
  description = "1-minute CloudWatch metrics instead of the free 5-minute default. Real per-instance cost when enabled."
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags applied to the instance (merged with a Name tag from var.name)."
  type        = map(string)
  default     = {}
}
