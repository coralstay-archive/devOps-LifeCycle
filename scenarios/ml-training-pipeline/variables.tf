variable "name" {
  description = "Base name used as the prefix/tag for the artifacts bucket and the Step Functions state machine orchestrating the training pipeline."
  type        = string
  default     = "ml-training-pipeline"
}
