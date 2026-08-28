variable "name" {
  description = "Base name for the SageMaker model, endpoint configuration, endpoint, and IAM role."
  type        = string
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
  description = "Instance type backing the endpoint's production variant (e.g. ml.t2.medium, ml.m5.large)."
  type        = string
  default     = "ml.t2.medium"
}

variable "initial_instance_count" {
  description = "Number of instances behind the endpoint's production variant. Must be at least 1 -- enforced by this module's precondition."
  type        = number
  default     = 1
}

variable "endpoint_kms_key_arn" {
  description = "KMS key ARN to encrypt the endpoint's inference storage volume at rest (e.g. from the kms module). Leave null to skip — SageMaker has no AWS-managed-key fallback here, so this volume is genuinely unencrypted without one."
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags applied to the model, endpoint configuration, endpoint, and IAM role."
  type        = map(string)
  default     = {}
}
