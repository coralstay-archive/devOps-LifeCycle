variable "function_name" {
  type = string
}

variable "filename" {
  description = "Path to the deployment package zip"
  type        = string
}

variable "handler" {
  type    = string
  default = "index.handler"
}

variable "runtime" {
  type    = string
  default = "python3.13"
}

variable "memory_size" {
  type    = number
  default = 128
}

variable "timeout" {
  type    = number
  default = 10
}

variable "environment_variables" {
  type    = map(string)
  default = {}
}

variable "log_retention_days" {
  type    = number
  default = 14
}

variable "tags" {
  type    = map(string)
  default = {}
}
