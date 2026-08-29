variable "name" {
  description = "Base name for every module in the stack (VPC, ECR, ALB, ECS service, RDS, observability)."
  type        = string
  default     = "standard-web"
}

variable "availability_zones" {
  description = "Availability zones to spread subnets across (multi-AZ by default for spike resilience)"
  type        = list(string)
  default     = ["ap-northeast-2a", "ap-northeast-2c"]
}

variable "container_image" {
  description = "Placeholder public image so this plans/applies out of the box. Swap for your app's image in modules.ecr's repository once you have one."
  type        = string
  default     = "public.ecr.aws/nginx/nginx:1.27"
}
