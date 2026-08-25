variable "name" {
  type    = string
  default = "private-vpc-only"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "availability_zones" {
  type    = list(string)
  default = ["ap-northeast-2a", "ap-northeast-2c"]
}

variable "region" {
  type    = string
  default = "ap-northeast-2"
}
