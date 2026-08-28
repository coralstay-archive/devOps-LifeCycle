variable "cluster_identifier" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "allowed_security_group_ids" {
  type    = list(string)
  default = []
}

variable "node_type" {
  type    = string
  default = "dc2.large"
}

variable "master_username" {
  type    = string
  default = "admin"
}

variable "database_name" {
  type    = string
  default = "app"
}

variable "skip_final_snapshot" {
  type    = bool
  default = false
}

variable "tags" {
  type    = map(string)
  default = {}
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
