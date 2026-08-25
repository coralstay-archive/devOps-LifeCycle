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
