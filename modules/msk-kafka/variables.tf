variable "cluster_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "private_subnet_ids" {
  description = "Needs >= 2 AZs"
  type        = list(string)
}

variable "allowed_security_group_ids" {
  type    = list(string)
  default = []
}

variable "kafka_version" {
  type    = string
  default = "3.7.x"
}

variable "broker_instance_type" {
  type    = string
  default = "kafka.t3.small"
}

variable "number_of_broker_nodes" {
  description = "Must be a multiple of the number of subnets (AZs)"
  type        = number
  default     = 2
}

variable "broker_volume_size" {
  type    = number
  default = 100
}

variable "tags" {
  type    = map(string)
  default = {}
}
