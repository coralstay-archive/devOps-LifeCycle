variable "cluster_name" {
  description = "Name of the EKS cluster."
  type        = string
}

variable "private_subnet_ids" {
  description = "Needs >= 2 AZs; used for both the control plane ENIs and worker nodes"
  type        = list(string)
}

variable "kubernetes_version" {
  description = "EKS control plane Kubernetes version."
  type        = string
  default     = "1.31"
}

variable "node_instance_types" {
  description = "EC2 instance types available to the default managed node group."
  type        = list(string)
  default     = ["t3.medium"]
}

variable "node_desired_size" {
  description = "Desired node count for the default managed node group. Must satisfy node_min_size <= node_desired_size <= node_max_size."
  type        = number
  default     = 2
}

variable "node_min_size" {
  description = "Minimum node count the managed node group will scale down to."
  type        = number
  default     = 2
}

variable "node_max_size" {
  description = "Maximum node count the managed node group will scale up to."
  type        = number
  default     = 4
}

variable "cluster_log_types" {
  description = "Control plane log types to enable (e.g. [\"api\", \"audit\", \"authenticator\", \"controllerManager\", \"scheduler\"]). Defaults to none — enabling any incurs ongoing CloudWatch Logs cost."
  type        = list(string)
  default     = []
}

variable "public_access_cidrs" {
  description = "CIDR blocks allowed to reach the public API endpoint. Defaults to open (0.0.0.0/0) to preserve out-of-the-box kubectl access — narrow this for anything beyond a scaffold."
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "secrets_kms_key_arn" {
  description = "KMS key ARN to encrypt Kubernetes Secrets at rest (e.g. from the kms module). Leave null to skip envelope encryption of Secrets."
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags applied to the cluster and node group."
  type        = map(string)
  default     = {}
}
