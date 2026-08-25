variable "name" {
  type    = string
  default = "multi-tenant-saas"
}

variable "availability_zones" {
  type    = list(string)
  default = ["ap-northeast-2a", "ap-northeast-2c"]
}
