variable "name" {
  description = "Name for the Athena workgroup."
  type        = string
}

variable "output_location" {
  description = "e.g. s3://my-bucket/athena-results/"
  type        = string
}

variable "tags" {
  description = "Tags applied to the workgroup."
  type        = map(string)
  default     = {}
}
