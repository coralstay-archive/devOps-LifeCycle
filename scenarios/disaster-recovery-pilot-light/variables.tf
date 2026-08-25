variable "name" {
  type    = string
  default = "disaster-recovery-pilot-light"
}

variable "availability_zones" {
  type    = list(string)
  default = ["ap-northeast-2a", "ap-northeast-2c"]
}
