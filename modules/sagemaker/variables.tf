variable "name" {
  type = string
}

variable "container_image" {
  description = "ECR image URI serving the model"
  type        = string
}

variable "model_data_url" {
  description = "S3 URI of the packaged model artifact (model.tar.gz)"
  type        = string
}

variable "instance_type" {
  type    = string
  default = "ml.t2.medium"
}

variable "initial_instance_count" {
  type    = number
  default = 1
}

variable "tags" {
  type    = map(string)
  default = {}
}
