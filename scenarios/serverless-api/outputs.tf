output "api_endpoint" {
  description = "Invoke URL for the HTTP API's auto-deployed $default stage."
  value       = module.api_gateway.api_endpoint
}
