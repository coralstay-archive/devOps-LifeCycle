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

variable "log_retention_days" {
  description = "State machine execution log group retention. Checkov wants >= 365 for compliance; defaults to 14 here to match this repo's cost-conscious convention (see lambda's log_retention_days) — raise it per caller when needed."
  type        = number
  default     = 14
}

variable "log_kms_key_arn" {
  description = "Customer-managed KMS key for the execution log group. Defaults to null, which uses CloudWatch Logs' default encryption."
  type        = string
  default     = null
}

variable "tags" {
  type    = map(string)
  default = {}
}
