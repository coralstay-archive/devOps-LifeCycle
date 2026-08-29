variable "name" {
  description = "Name prefix passed through to every module this scenario composes (s3-bucket, glue, athena)."
  type        = string
  default     = "data-lake"
}
