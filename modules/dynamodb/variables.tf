variable "table_name" {
  type = string
}

variable "hash_key" {
  type    = string
  default = "id"
}

variable "hash_key_type" {
  description = "S, N, or B"
  type        = string
  default     = "S"
}

variable "tags" {
  type    = map(string)
  default = {}
}
