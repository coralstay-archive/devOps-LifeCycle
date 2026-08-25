variable "name" {
  type    = string
  default = "read-heavy-caching"
}

variable "availability_zones" {
  type    = list(string)
  default = ["ap-northeast-2a", "ap-northeast-2c"]
}
