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

variable "endpoint_kms_key_arn" {
  description = "KMS key ARN to encrypt the endpoint's inference storage volume at rest (e.g. from the kms module). Leave null to skip — SageMaker has no AWS-managed-key fallback here, so this volume is genuinely unencrypted without one."
  type        = string
  default     = null
}

variable "tags" {
  type    = map(string)
  default = {}
}
