variable "name" {
  description = "Name used as the base for the replication instance, task, and endpoint identifiers."
  type        = string
}

variable "vpc_id" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "replication_instance_class" {
  type    = string
  default = "dms.t3.micro"
}

variable "source_engine_name" {
  description = "e.g. postgres, mysql"
  type        = string
  default     = "postgres"
}

variable "source_server_name" {
  type = string
}

variable "source_port" {
  type    = number
  default = 5432
}

variable "source_database_name" {
  type = string
}

variable "source_username" {
  type = string
}

variable "source_password" {
  type      = string
  sensitive = true
}

variable "target_engine_name" {
  type    = string
  default = "kafka"
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
  type    = map(string)
  default = {}
}

variable "kms_key_arn" {
  description = "Customer-managed KMS key for the replication instance and both endpoints. Defaults to null, which falls back to the AWS-managed aws/dms key."
  type        = string
  default     = null
}
