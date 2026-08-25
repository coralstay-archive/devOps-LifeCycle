variable "name" {
  description = "Name prefix for the alarm SNS topic and dashboard"
  type        = string
}

variable "alarm_email" {
  description = "Email to subscribe to the alarm SNS topic. Leave null to skip (wire Slack/PagerDuty separately)."
  type        = string
  default     = null
}

variable "alarms" {
  description = "Map of CloudWatch alarms to create, keyed by a short name"
  type = map(object({
    metric_name         = string
    namespace           = string
    statistic           = string
    period              = number
    evaluation_periods  = number
    threshold           = number
    comparison_operator = string
    dimensions          = map(string)
  }))
  default = {}
}

variable "tags" {
  type    = map(string)
  default = {}
}
