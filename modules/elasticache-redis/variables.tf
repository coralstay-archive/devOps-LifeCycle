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

variable "tags" {
  type    = map(string)
  default = {}
}
