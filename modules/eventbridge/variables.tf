variable "name" {
  description = "Name of the EventBridge rule."
  type        = string
}

variable "schedule_expression" {
  description = "e.g. rate(5 minutes) or cron(...). Mutually exclusive with event_pattern."
  type        = string
  default     = null
}

variable "event_pattern" {
  description = "JSON event pattern string. Mutually exclusive with schedule_expression."
  type        = string
  default     = null
}

variable "target_arn" {
  description = "ARN the rule invokes when it fires (e.g. a Lambda function ARN, SQS queue ARN, or Step Functions state machine ARN)."
  type        = string
}

variable "target_is_lambda" {
  description = "Set true if target_arn is a Lambda function, to attach the invoke permission"
  type        = bool
  default     = false
}
