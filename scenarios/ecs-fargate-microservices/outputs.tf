output "alb_dns_names" {
  description = "Each service's ALB DNS name, keyed by entry in var.services -- one ALB per service, not shared."
  value       = { for k, a in module.alb : k => a.dns_name }
}
