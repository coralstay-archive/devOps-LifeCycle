variable "name" {
  type    = string
  default = "scheduled-batch-jobs"
}

variable "schedule_expression" {
  type    = string
  default = "rate(1 hour)"
}
