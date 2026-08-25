output "bucket_id" {
  value = module.lake_bucket.bucket_id
}

output "glue_database_name" {
  value = module.glue.database_name
}

output "athena_workgroup_name" {
  value = module.athena.workgroup_name
}
