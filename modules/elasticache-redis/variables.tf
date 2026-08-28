variable "name" {
  description = "Name for the Redis replication group"
  type        = string
}

variable "vpc_id" {
  description = "VPC to place the replication group's security group in."
  type        = string
}

variable "private_subnet_ids" {
  description = "Private subnet IDs for the ElastiCache subnet group."
  type        = list(string)
}

variable "allowed_security_group_ids" {
  description = "Application security group IDs allowed to reach Redis on port 6379. Empty means nothing can connect -- Redis is never opened to a CIDR range, only to specific approved security groups."
  type        = list(string)
  default     = []
}

variable "node_type" {
  description = "ElastiCache node instance class."
  type        = string
  default     = "cache.t4g.micro"
}

variable "num_cache_nodes" {
  description = "Number of nodes (1 primary + N-1 replicas)"
  type        = number
  default     = 2
}

variable "auth_token" {
  description = "Redis AUTH token (16-128 chars). Plain sensitive variable for simplicity, same pattern as modules/dms's source_password — read it from modules/secrets-manager instead of a bare tfvar in practice. Null disables AUTH."
  type        = string
  sensitive   = true
  default     = null
}

variable "kms_key_arn" {
  description = "Customer-managed KMS key for at-rest encryption (already on via the AWS-managed key). Leave null to keep using the AWS-managed key."
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags applied to all resources."
  type        = map(string)
  default     = {}
}
