variable "name" {
  description = "Base name used as the prefix/tag for the SNS/SQS messaging resources and the consumer Lambda."
  type        = string
  default     = "event-driven-microservices"
}
