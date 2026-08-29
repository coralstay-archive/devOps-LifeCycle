variable "name" {
  description = "Name prefix applied to the observability module's alarms and dashboard."
  type        = string
  default     = "observability-only-baseline"
}

variable "alarm_email" {
  description = "Email address to subscribe to the alarm SNS topic. Null skips the subscription -- the topic still exists, just with no email endpoint."
  type        = string
  default     = null
}
