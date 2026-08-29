output "alb_dns_name" {
  description = "Public DNS name of the ALB fronting the ECS service."
  value       = module.alb.dns_name
}

output "rds_endpoint" {
  description = "Connection endpoint (host:port) of the Postgres instance."
  value       = module.rds.endpoint
}

output "ecr_repository_url" {
  description = "URI to push the application's container image to before ecs_service can pull it."
  value       = module.ecr.repository_url
}
