variable "cluster_name" {
  description = "Name of the MSK cluster"
  type        = string
}

variable "vpc_id" {
  description = "VPC to place the cluster's security group in"
  type        = string
}

variable "private_subnet_ids" {
  description = "Needs >= 2 AZs"
  type        = list(string)
}

variable "allowed_security_group_ids" {
  description = "Security groups allowed to connect to the Kafka TLS listener (port 9094)"
  type        = list(string)
  default     = []
}

variable "kafka_version" {
  description = "Apache Kafka version MSK runs on the brokers"
  type        = string
  default     = "3.7.x"
}

variable "broker_instance_type" {
  description = "EC2 instance type for each broker node"
  type        = string
  default     = "kafka.t3.small"
}

variable "number_of_broker_nodes" {
  description = "Must be a multiple of the number of subnets (AZs)"
  type        = number
  default     = 2
}

variable "broker_volume_size" {
  description = "EBS volume size per broker, in GB"
  type        = number
  default     = 100
}

variable "encryption_at_rest_kms_key_arn" {
  description = "Customer-managed KMS key for broker EBS storage at rest. Defaults to null, which lets MSK apply its own AWS-managed key automatically."
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags applied to the cluster, its security group, and its broker log group"
  type        = map(string)
  default     = {}
}
