variable "organizational_units" {
  description = "OU names to create directly under the org root"
  type        = list(string)
  default     = ["Security", "Workloads"]
}

variable "tags" {
  type    = map(string)
  default = {}
}
