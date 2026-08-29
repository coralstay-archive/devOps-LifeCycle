variable "name" {
  description = "Base name for the Lambda job function and its EventBridge schedule rule."
  type        = string
  default     = "scheduled-batch-jobs"
}

variable "schedule_expression" {
  description = "EventBridge schedule expression (rate(...) or cron(...)) controlling how often the job runs."
  type        = string
  default     = "rate(1 hour)"
}
