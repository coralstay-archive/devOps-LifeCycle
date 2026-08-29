output "endpoint_name" {
  description = "SageMaker real-time inference endpoint name -- invoke it directly for predictions."
  value       = module.endpoint.endpoint_name
}
