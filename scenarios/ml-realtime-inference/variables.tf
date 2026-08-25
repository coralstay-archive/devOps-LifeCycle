variable "name" {
  type    = string
  default = "ml-realtime-inference"
}

variable "container_image" {
  description = "ECR image URI serving the model — no sensible default, fill in before apply"
  type        = string
}

variable "model_data_url" {
  description = "S3 URI of the packaged model artifact — no sensible default, fill in before apply"
  type        = string
}
