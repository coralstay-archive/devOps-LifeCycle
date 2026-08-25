variable "database_name" {
  type = string
}

variable "s3_target_path" {
  description = "e.g. s3://my-bucket/raw/"
  type        = string
}

variable "crawler_schedule" {
  description = "cron() expression. Leave null to run on-demand only."
  type        = string
  default     = null
}

variable "tags" {
  type    = map(string)
  default = {}
}
