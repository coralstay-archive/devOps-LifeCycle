variable "name" {
  type = string
}

variable "secret_string" {
  description = "Initial secret value. Leave null to create an empty secret and fill it in outside Terraform (recommended for anything rotated)."
  type        = string
  default     = null
  sensitive   = true
}

variable "tags" {
  type    = map(string)
  default = {}
}
