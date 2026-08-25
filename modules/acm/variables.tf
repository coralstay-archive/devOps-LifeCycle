variable "domain_name" {
  type = string
}

variable "zone_id" {
  description = "Route53 zone ID used for DNS validation (see the route53 module's zone_id output)"
  type        = string
}

variable "subject_alternative_names" {
  type    = list(string)
  default = []
}
