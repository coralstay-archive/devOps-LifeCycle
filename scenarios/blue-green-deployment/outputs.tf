output "alb_dns_name" {
  description = "Public DNS name of the ALB fronting both the blue and green target groups."
  value       = module.alb.dns_name
}

output "codedeploy_app_name" {
  description = "Name of the CodeDeploy application that shifts traffic between the blue and green target groups."
  value       = module.deploy.app_name
}
