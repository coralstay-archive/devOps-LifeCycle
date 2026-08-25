variable "vpc_id" {
  type = string
}

variable "vpc_cidr_block" {
  type = string
}

variable "region" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "route_table_ids" {
  description = "Route tables the S3/DynamoDB gateway endpoints attach to"
  type        = list(string)
}

variable "interface_services" {
  description = "Short service names, e.g. ecr.api, ecr.dkr, logs"
  type        = list(string)
  default     = ["ecr.api", "ecr.dkr", "logs"]
}

variable "tags" {
  type    = map(string)
  default = {}
}
