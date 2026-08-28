output "function_name" {
  description = "Name of the created Lambda function"
  value       = aws_lambda_function.this.function_name
}

output "function_arn" {
  description = "ARN of the created Lambda function"
  value       = aws_lambda_function.this.arn
}

output "invoke_arn" {
  description = "Invocation ARN for wiring into an API Gateway integration (aws_apigatewayv2_integration.integration_uri)"
  value       = aws_lambda_function.this.invoke_arn
}

output "role_arn" {
  description = "ARN of the function's execution IAM role"
  value       = aws_iam_role.this.arn
}

output "role_name" {
  description = "Name of the function's execution IAM role"
  value       = aws_iam_role.this.name
}
