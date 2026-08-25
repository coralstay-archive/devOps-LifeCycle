output "role_arn" {
  description = "ARN of the IAM role GitHub Actions assumes via OIDC"
  value       = aws_iam_role.this.arn
}

output "oidc_provider_arn" {
  description = "ARN of the GitHub OIDC provider used"
  value       = local.oidc_provider_arn
}
