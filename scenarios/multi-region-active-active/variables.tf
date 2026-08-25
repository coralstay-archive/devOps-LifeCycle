variable "name" {
  type    = string
  default = "multi-region-active-active"
}

variable "primary_region" {
  type    = string
  default = "ap-northeast-2"
}

variable "secondary_region" {
  type    = string
  default = "us-east-1"
}

variable "primary_azs" {
  type    = list(string)
  default = ["ap-northeast-2a", "ap-northeast-2c"]
}

variable "secondary_azs" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b"]
}

variable "domain_name" {
  description = "Real domain you own — no sensible default"
  type        = string
}
