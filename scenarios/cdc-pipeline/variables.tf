variable "name" {
  type    = string
  default = "cdc-pipeline"
}

variable "availability_zones" {
  type    = list(string)
  default = ["ap-northeast-2a", "ap-northeast-2c"]
}

variable "source_db_password" {
  description = "Password for a dedicated DMS read user on the source DB (not the RDS master password, which is Secrets-Manager-managed and not exposed as plaintext)"
  type        = string
  sensitive   = true
}
