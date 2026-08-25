variable "name" {
  type = string
}

variable "schedule" {
  description = "Cron expression, default daily at 05:00 UTC"
  type        = string
  default     = "cron(0 5 * * ? *)"
}

variable "retention_days" {
  type    = number
  default = 35
}

variable "resource_arns" {
  description = "ARNs to back up"
  type        = list(string)
  default     = []
}

variable "tags" {
  type    = map(string)
  default = {}
}
