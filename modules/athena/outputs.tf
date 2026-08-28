output "workgroup_name" {
  description = "Workgroup name -- pass to query clients so they inherit its enforced output_location/encryption settings."
  value       = aws_athena_workgroup.this.name
}
