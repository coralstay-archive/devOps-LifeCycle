variable "cluster_identifier" {
  description = "Redshift cluster identifier"
  type        = string
}

variable "vpc_id" {
  description = "VPC to place the cluster's subnet group and security group in"
  type        = string
}

variable "private_subnet_ids" {
  description = "Private subnet IDs for the cluster's subnet group"
  type        = list(string)
}

variable "allowed_security_group_ids" {
  description = "Security groups allowed to connect on port 5439"
  type        = list(string)
  default     = []
}

variable "node_type" {
  description = "Redshift node type for the single-node cluster"
  type        = string
  default     = "dc2.large"
}

variable "master_username" {
  description = "Master username -- not the real security boundary here (the master password is AWS-managed via Secrets Manager, see manage_master_password), just an identifier"
  type        = string
  default     = "admin"
}

variable "database_name" {
  description = "Initial database name -- must start with a lowercase letter and contain only lowercase alphanumerics/underscore, Redshift's own naming rule enforced by this module's precondition"
  type        = string
  default     = "app"
}

variable "skip_final_snapshot" {
  description = "Skip the final snapshot on destroy (keep false for anything holding real data)"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags applied to the cluster, its subnet group, and its security group"
  type        = map(string)
  default     = {}
}

variable "kms_key_arn" {
  description = "Customer-managed KMS key for cluster encryption. Leave null to use the AWS-managed aws/redshift key (current default)."
  type        = string
  default     = null
}

variable "enhanced_vpc_routing" {
  description = "Route COPY/UNLOAD traffic through the VPC instead of the public internet (free; requires the VPC to have a route to S3, e.g. via vpc-endpoints)"
  type        = bool
  default     = true
}

variable "logging_bucket_name" {
  description = "S3 bucket to receive Redshift audit logs (must already exist with the Redshift log-delivery bucket policy attached). Leave null to disable audit logging."
  type        = string
  default     = null
}

variable "logging_s3_key_prefix" {
  description = "S3 key prefix for audit logs, used only when logging_bucket_name is set"
  type        = string
  default     = null
}
