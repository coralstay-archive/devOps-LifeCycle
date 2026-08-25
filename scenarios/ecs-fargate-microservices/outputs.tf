output "alb_dns_names" {
  value = { for k, a in module.alb : k => a.dns_name }
}
