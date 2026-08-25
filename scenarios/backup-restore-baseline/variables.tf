variable "name" {
  type    = string
  default = "backup-restore-baseline"
}

variable "availability_zones" {
  type    = list(string)
  default = ["ap-northeast-2a", "ap-northeast-2c"]
}
