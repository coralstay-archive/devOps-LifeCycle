variable "name" {
  description = "Name used as the base for the replication instance, task, and endpoint identifiers."
  type        = string
}

variable "vpc_id" {
  description = "VPC to place the replication instance's security group in."
  type        = string
}

variable "private_subnet_ids" {
  description = "Private subnet IDs for the DMS replication subnet group."
  type        = list(string)
}

variable "replication_instance_class" {
  description = "DMS replication instance size, e.g. dms.t3.micro for light workloads."
  type        = string
  default     = "dms.t3.micro"
}

variable "source_engine_name" {
  description = "e.g. postgres, mysql"
  type        = string
  default     = "postgres"
}

variable "source_server_name" {
  description = "Hostname or IP address of the source database DMS reads change data from."
  type        = string
}

variable "source_port" {
  description = "TCP port the source database listens on."
  type        = number
  default     = 5432
}

variable "source_database_name" {
  description = "Name of the source database to migrate/replicate from."
  type        = string
}

variable "source_username" {
  description = "Username DMS uses to connect to the source database."
  type        = string
}

variable "source_password" {
  description = "Password DMS uses to connect to the source database. Plain sensitive variable for simplicity -- see this module's README for why that's a trade-off, not the ideal end state."
  type        = string
  sensitive   = true
}

variable "target_engine_name" {
  description = "DMS target engine, e.g. \"kafka\" (default) or \"s3\" -- changing this requires updating the kafka_settings block in main.tf to match the new target."
  type        = string
  default     = "kafka"
}

variable "target_kafka_broker" {
  description = "Used when target_engine_name = kafka: broker1:port,broker2:port"
  type        = string
  default     = null
}

variable "table_mappings" {
  description = "DMS table mapping JSON. Defaults to capturing every table in every schema."
  type        = string
  default     = <<-EOT
  {
    "rules": [{
      "rule-type": "selection",
      "rule-id": "1",
      "rule-name": "1",
      "object-locator": { "schema-name": "%", "table-name": "%" },
      "rule-action": "include"
    }]
  }
  EOT
}

variable "tags" {
  description = "Tags applied to all resources."
  type        = map(string)
  default     = {}
}

variable "kms_key_arn" {
  description = "Customer-managed KMS key for the replication instance and both endpoints. Defaults to null, which falls back to the AWS-managed aws/dms key."
  type        = string
  default     = null
}
