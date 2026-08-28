variable "name" {
  type = string
}

variable "lambda_invoke_arn" {
  description = "invoke_arn output from the lambda module"
  type        = string
}

variable "lambda_function_name" {
  type = string
}

variable "route_key" {
  description = "e.g. \"GET /items\" or \"$default\""
  type        = string
  default     = "$default"
}

variable "log_retention_days" {
  description = "CloudWatch retention for the stage's access log group."
  type        = number
  default     = 14
}

variable "tags" {
  description = "Tags applied to the access-log group."
  type        = map(string)
  default     = {}
}
