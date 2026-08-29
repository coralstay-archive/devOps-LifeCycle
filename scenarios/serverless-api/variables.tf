variable "name" {
  description = "Base name for the DynamoDB table, Lambda function, and API Gateway HTTP API."
  type        = string
  default     = "serverless-api"
}
