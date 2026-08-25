variable "name" {
  type = string
}

variable "definition" {
  description = "Amazon States Language JSON. Defaults to a trivial single-Pass-state machine so this module works with zero required config beyond `name`."
  type        = string
  default     = <<-EOT
  {
    "Comment": "Placeholder state machine - replace with a real definition",
    "StartAt": "Placeholder",
    "States": {
      "Placeholder": {
        "Type": "Pass",
        "End": true
      }
    }
  }
  EOT
}

variable "policy_arns" {
  description = "Managed policy ARNs to attach (e.g. to let it invoke Lambda/Glue)"
  type        = list(string)
  default     = []
}

variable "tags" {
  type    = map(string)
  default = {}
}
