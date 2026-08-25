variable "name" {
  type    = string
  default = "eks-multi-tenant-cluster"
}

variable "availability_zones" {
  type    = list(string)
  default = ["ap-northeast-2a", "ap-northeast-2c"]
}
