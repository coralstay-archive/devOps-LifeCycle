variable "vpc_id" {
  description = "VPC to attach the gateway and interface endpoints to."
  type        = string
}

variable "vpc_cidr_block" {
  description = "The VPC's CIDR block -- scopes the interface endpoints' security group ingress to traffic originating inside the VPC."
  type        = string
}

variable "region" {
  description = "AWS region, used to build each endpoint's service_name (e.g. com.amazonaws.<region>.s3)."
  type        = string
}

variable "private_subnet_ids" {
  description = "Subnets the interface endpoints' ENIs are placed in."
  type        = list(string)
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
  description = "Tags applied to the endpoints and the interface endpoints' security group."
  type        = map(string)
  default     = {}
}
