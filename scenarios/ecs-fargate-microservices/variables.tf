variable "name" {
  type    = string
  default = "ecs-fargate-microservices"
}

variable "availability_zones" {
  type    = list(string)
  default = ["ap-northeast-2a", "ap-northeast-2c"]
}

variable "services" {
  description = "One ALB + ECS service pair per entry"
  type        = list(string)
  default     = ["service-a", "service-b"]
}

variable "container_image" {
  description = "Placeholder image shared by all services for a quick smoke test"
  type        = string
  default     = "public.ecr.aws/nginx/nginx:1.27"
}
