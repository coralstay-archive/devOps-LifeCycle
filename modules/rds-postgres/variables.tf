variable "identifier" {
  description = "RDS instance identifier"
  type        = string
}

variable "vpc_id" {
  description = "VPC to place the instance in"
  type        = string
}

variable "private_subnet_ids" {
  description = "Private subnet IDs for the DB subnet group (needs >= 2 AZs)"
  type        = list(string)
}

variable "allowed_security_group_ids" {
  description = "Security groups allowed to connect to Postgres on port 5432"
  type        = list(string)
  default     = []
}

variable "engine_version" {
  description = "PostgreSQL engine version"
  type        = string
  default     = "16.4"
}

variable "instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.t4g.micro"
}

variable "allocated_storage" {
  description = "Allocated storage in GB"
  type        = number
  default     = 20
}

variable "multi_az" {
  description = "Enable Multi-AZ failover (spike/availability default: on)"
  type        = bool
  default     = true
}

variable "database_name" {
  description = "Initial database name"
  type        = string
  default     = "app"
}

variable "master_username" {
  description = "Master username"
  type        = string
  default     = "app_admin"
}

variable "skip_final_snapshot" {
  description = "Skip final snapshot on destroy (keep false for anything holding real data)"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags applied to all resources"
  type        = map(string)
  default     = {}
}
