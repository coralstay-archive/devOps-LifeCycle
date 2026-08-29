variable "organizational_units" {
  description = "OU names to create under the Organizations root -- passed straight through to modules/organizations-landing-zone."
  type        = list(string)
  default     = ["Security", "Workloads"]
}
