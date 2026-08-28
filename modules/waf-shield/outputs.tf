output "web_acl_arn" {
  description = "ARN of the web ACL -- pass this to a REGIONAL resource's web_acl association (e.g. aws_wafv2_web_acl_association for an ALB) or to cloudfront's web_acl_id."
  value       = aws_wafv2_web_acl.this.arn
}

output "web_acl_id" {
  description = "ID of the web ACL."
  value       = aws_wafv2_web_acl.this.id
}
