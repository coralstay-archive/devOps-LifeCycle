variable "name" {
  description = "Name for the collection and its security policies/IAM role. Must be 3-32 chars, lowercase, starting with a letter -- OpenSearch Serverless's collection naming rule, enforced by a precondition."
  type        = string
}

variable "tags" {
  description = "Tags applied to the collection and IAM role."
  type        = map(string)
  default     = {}
}
