variable "cluster_name" {
  type = string
}

variable "private_subnet_ids" {
  description = "Needs >= 2 AZs; used for both the control plane ENIs and worker nodes"
  type        = list(string)
}

variable "kubernetes_version" {
  type    = string
  default = "1.31"
}

variable "node_instance_types" {
  type    = list(string)
  default = ["t3.medium"]
}

variable "node_desired_size" {
  type    = number
  default = 2
}

variable "node_min_size" {
  type    = number
  default = 2
}

variable "node_max_size" {
  type    = number
  default = 4
}

variable "secrets_kms_key_arn" {
  description = "KMS key ARN to encrypt Kubernetes Secrets at rest (e.g. from the kms module). Leave null to skip envelope encryption of Secrets."
  type        = string
  default     = null
}

variable "tags" {
  type    = map(string)
  default = {}
}
