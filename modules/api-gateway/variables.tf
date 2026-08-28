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

variable "authorization_type" {
  description = "Route authorization: \"NONE\" (default, matches this module's original unauthenticated behavior), \"AWS_IAM\", \"JWT\", or \"CUSTOM\". Not forced on -- requiring an authorizer here by default would be a breaking change for every existing caller."
  type        = string
  default     = "NONE"
}

variable "authorizer_id" {
  description = "aws_apigatewayv2_authorizer ID, required when authorization_type is \"JWT\" or \"CUSTOM\". This module doesn't create the authorizer itself -- pass one in from a scenario that needs gateway-level auth (e.g. a Cognito user pool JWT authorizer)."
  type        = string
  default     = null
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
