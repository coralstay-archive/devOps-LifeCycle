output "endpoint_name" {
  value = aws_sagemaker_endpoint.this.name
}

output "role_arn" {
  value = aws_iam_role.this.arn
}
