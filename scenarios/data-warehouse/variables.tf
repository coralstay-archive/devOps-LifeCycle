variable "name" {
  description = "Name prefix passed through to every module this scenario composes (vpc, redshift)."
  type        = string
  default     = "data-warehouse"
}

variable "availability_zones" {
  description = "Availability zones for the vpc module to spread subnets across (multi-AZ by default)."
  type        = list(string)
  default     = ["ap-northeast-2a", "ap-northeast-2c"]
}
