output "dns_name" {
  description = "The ALB's public DNS name -- point a Route53 alias record at this."
  value       = aws_lb.this.dns_name
}

output "target_group_arn" {
  description = "ARN of the single target group -- feed into ecs-service to register tasks against it."
  value       = aws_lb_target_group.this.arn
}

output "target_group_name" {
  description = "Name of the single target group."
  value       = aws_lb_target_group.this.name
}

output "security_group_id" {
  description = "Security group ID for the ALB itself -- reference this from a backend module's ingress rules to scope access to traffic from this ALB only."
  value       = aws_security_group.this.id
}

output "arn_suffix" {
  description = "Shortened ARN suffix used by CloudWatch metrics/dashboards for this ALB."
  value       = aws_lb.this.arn_suffix
}

output "arn" {
  description = "Full ARN of the load balancer."
  value       = aws_lb.this.arn
}

output "listener_arn" {
  description = "The externally-facing listener: HTTPS if certificate_arn was set, else HTTP"
  value       = var.certificate_arn == null ? aws_lb_listener.http.arn : aws_lb_listener.https[0].arn
}
