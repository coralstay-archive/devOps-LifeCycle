variable "name" {
  description = "Base name used as the prefix/tag for the Glue database/crawler and the Step Functions state machine orchestrating them."
  type        = string
  default     = "etl-batch"
}
