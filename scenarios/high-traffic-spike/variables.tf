variable "name" {
  type    = string
  default = "high-traffic-spike"
}

variable "availability_zones" {
  type    = list(string)
  default = ["ap-northeast-2a", "ap-northeast-2c"]
}
