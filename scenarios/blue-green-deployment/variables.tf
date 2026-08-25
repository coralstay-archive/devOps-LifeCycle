variable "name" {
  type    = string
  default = "blue-green-deployment"
}

variable "availability_zones" {
  type    = list(string)
  default = ["ap-northeast-2a", "ap-northeast-2c"]
}

variable "container_image" {
  type    = string
  default = "public.ecr.aws/nginx/nginx:1.27"
}
