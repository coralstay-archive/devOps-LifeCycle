variable "name" {
  type    = string
  default = "standard-web"
}

variable "availability_zones" {
  type    = list(string)
  default = ["ap-northeast-2a", "ap-northeast-2c"]
}

variable "container_image" {
  description = "Placeholder public image so this plans/applies out of the box. Swap for your app's image in modules.ecr's repository once you have one."
  type        = string
  default     = "public.ecr.aws/nginx/nginx:1.27"
}
