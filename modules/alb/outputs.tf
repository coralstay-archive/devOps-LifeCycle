output "dns_name" {
  value = aws_lb.this.dns_name
}

output "target_group_arn" {
  value = aws_lb_target_group.this.arn
}

output "target_group_name" {
  value = aws_lb_target_group.this.name
}

output "security_group_id" {
  value = aws_security_group.this.id
}

output "arn_suffix" {
  value = aws_lb.this.arn_suffix
}

output "arn" {
  value = aws_lb.this.arn
}

output "listener_arn" {
  description = "The externally-facing listener: HTTPS if certificate_arn was set, else HTTP"
  value       = var.certificate_arn == null ? aws_lb_listener.http.arn : aws_lb_listener.https[0].arn
}
