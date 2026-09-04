variable "github_org" {
  description = "GitHub organization or user that owns the repo allowed to assume this role"
  type        = string
}

variable "github_repo" {
  description = "Repository name (without org prefix) allowed to assume this role"
  type        = string
}

variable "allowed_ref" {
  description = "Git ref allowed to assume this role, e.g. refs/heads/main. Use \"*\" to allow any branch/PR (not recommended for a role with write access)."
  type        = string
  default     = "refs/heads/main"
}

variable "role_name" {
  description = "Name of the IAM role GitHub Actions will assume"
  type        = string
}

variable "policy_arns" {
  description = "List of managed policy ARNs to attach to the role"
  type        = list(string)
  default     = []
}

variable "create_oidc_provider" {
  description = "Whether to create the GitHub OIDC provider. Set to false if it already exists in this account (an AWS account can only have one)."
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags applied to the role"
  type        = map(string)
  default     = {}
}
