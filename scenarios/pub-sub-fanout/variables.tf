variable "name" {
  type    = string
  default = "pub-sub-fanout"
}

variable "queue_names" {
  description = "One SQS queue per subscriber, all fed by the same SNS topic"
  type        = list(string)
  default     = ["orders", "notifications"]
}
