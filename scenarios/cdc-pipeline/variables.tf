variable "name" {
  description = "Name prefix passed through to every module this scenario composes (vpc, rds-postgres, msk-kafka, dms)."
  type        = string
  default     = "cdc-pipeline"
}

variable "availability_zones" {
  description = "Availability zones for the vpc module to spread subnets across (multi-AZ by default)."
  type        = list(string)
  default     = ["ap-northeast-2a", "ap-northeast-2c"]
}

variable "source_db_password" {
  description = "Password for a dedicated DMS read user on the source DB (not the RDS master password, which is Secrets-Manager-managed and not exposed as plaintext)"
  type        = string
  sensitive   = true
}
