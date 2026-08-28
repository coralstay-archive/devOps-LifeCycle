variable "domain_name" {
  description = "Primary domain name the certificate covers (DNS validated via Route53)."
  type        = string
}

variable "zone_id" {
  description = "Route53 zone ID used for DNS validation (see the route53 module's zone_id output)"
  type        = string
}

variable "subject_alternative_names" {
  description = "Additional domain names the certificate covers besides domain_name. Must not repeat domain_name itself -- enforced by a precondition."
  type        = list(string)
  default     = []
}
