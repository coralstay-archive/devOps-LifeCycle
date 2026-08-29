output "alb_dns_name" {
  description = "Public DNS name of the ALB, protected by the associated WAF web ACL."
  value       = module.alb.dns_name
}

output "web_acl_arn" {
  description = "ARN of the REGIONAL-scope WAF web ACL associated with the ALB."
  value       = module.waf.web_acl_arn
}
