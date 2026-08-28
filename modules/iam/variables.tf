variable "name" {
  description = "Role name"
  type        = string
}

variable "assume_role_services" {
  description = "AWS service principals allowed to assume this role, e.g. [\"ec2.amazonaws.com\"]"
  type        = list(string)
}

variable "managed_policy_arns" {
  description = "Managed policy ARNs to attach"
  type        = list(string)
  default     = []
}

variable "inline_policy_json" {
  description = "Optional inline policy JSON for permissions with no suitable managed policy. Prefer managed_policy_arns when one exists."
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags applied to the IAM role"
  type        = map(string)
  default     = {}
}
