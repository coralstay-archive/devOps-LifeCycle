variable "name" {
  description = "Name prefix applied to all resources created by this module"
  type        = string
}

variable "cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "Availability zones to spread subnets across (multi-AZ by default for spike resilience)"
  type        = list(string)
}

variable "enable_nat_gateway" {
  description = "Create one NAT gateway per AZ so private subnets have outbound internet access"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags applied to all resources"
  type        = map(string)
  default     = {}
}
