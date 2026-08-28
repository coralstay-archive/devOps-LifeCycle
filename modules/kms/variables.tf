variable "name" {
  description = "Alias name (without the alias/ prefix)"
  type        = string
}

variable "deletion_window_in_days" {
  description = "Waiting period (7-30 days, a real KMS API range) before a scheduled key deletion becomes irreversible."
  type        = number
  default     = 30
}

variable "tags" {
  description = "Tags applied to the KMS key"
  type        = map(string)
  default     = {}
}
