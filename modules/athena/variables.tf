variable "name" {
  type = string
}

variable "output_location" {
  description = "e.g. s3://my-bucket/athena-results/"
  type        = string
}

variable "tags" {
  type    = map(string)
  default = {}
}
