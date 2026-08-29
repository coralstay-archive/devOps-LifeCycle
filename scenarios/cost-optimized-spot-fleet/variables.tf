variable "name" {
  description = "Name prefix passed through to every module this scenario composes (vpc, ecs-service)."
  type        = string
  default     = "cost-optimized-spot-fleet"
}

variable "availability_zones" {
  description = "Availability zones for the vpc module to spread subnets across (multi-AZ by default)."
  type        = list(string)
  default     = ["ap-northeast-2a", "ap-northeast-2c"]
}

variable "container_image" {
  description = "Container image URI for the ecs-service task definition (e.g. from the ecr module's repository_url output)."
  type        = string
  default     = "public.ecr.aws/nginx/nginx:1.27"
}
