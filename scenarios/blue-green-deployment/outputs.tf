output "alb_dns_name" {
  value = module.alb.dns_name
}

output "codedeploy_app_name" {
  value = module.deploy.app_name
}
