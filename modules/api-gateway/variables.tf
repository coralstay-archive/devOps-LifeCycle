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
