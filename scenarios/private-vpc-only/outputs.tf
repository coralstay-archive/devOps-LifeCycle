output "vpc_id" {
  value = module.vpc.vpc_id
}

output "interface_endpoint_ids" {
  value = module.endpoints.interface_endpoint_ids
}
