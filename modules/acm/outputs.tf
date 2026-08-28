output "certificate_arn" {
  description = "ARN of the validated certificate (only resolves once DNS validation completes) -- feed into alb/cloudfront's certificate_arn."
  value       = aws_acm_certificate_validation.this.certificate_arn
}
