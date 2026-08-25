variable "domain_name" {
  type = string
}

variable "create_zone" {
  description = "Create a new hosted zone. Set false to use an existing zone for domain_name instead."
  type        = bool
  default     = true
}

variable "records" {
  description = "Map keyed by record name of { type, ttl, values }"
  type = map(object({
    type   = string
    ttl    = number
    values = list(string)
  }))
  default = {}
}
