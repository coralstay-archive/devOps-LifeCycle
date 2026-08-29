output "redshift_endpoint" {
  description = "Connection endpoint for the Redshift cluster."
  value       = module.redshift.endpoint
}
