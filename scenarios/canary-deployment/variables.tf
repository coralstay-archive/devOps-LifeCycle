variable "name" {
  type    = string
  default = "canary-deployment"
}

variable "availability_zones" {
  type    = list(string)
  default = ["ap-northeast-2a", "ap-northeast-2c"]
}
