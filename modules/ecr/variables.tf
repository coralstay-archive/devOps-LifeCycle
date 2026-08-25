variable "name" {
  description = "Repository name"
  type        = string
}

variable "untagged_image_expiry_days" {
  type    = number
  default = 14
}

variable "tags" {
  type    = map(string)
  default = {}
}
