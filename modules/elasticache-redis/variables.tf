variable "name" {
  description = "Name for the Redis replication group"
  type        = string
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
  default = "cache.t4g.micro"
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
  type    = map(string)
  default = {}
}
