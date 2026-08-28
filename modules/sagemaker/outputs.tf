output "endpoint_name" {
  description = "Name of the live, invokable SageMaker endpoint -- pass this to application code calling for predictions."
  value       = aws_sagemaker_endpoint.this.name
}

output "role_arn" {
  description = "ARN of the IAM role SageMaker assumes to run the model/endpoint (AmazonSageMakerFullAccess attached)."
  value       = aws_iam_role.this.arn
}
