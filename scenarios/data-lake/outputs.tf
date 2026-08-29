output "bucket_id" {
  description = "S3 bucket holding the lake's raw/ zone and Athena query results."
  value       = module.lake_bucket.bucket_id
}

output "glue_database_name" {
  description = "Glue Catalog database the crawler populates from the bucket's raw/ prefix."
  value       = module.glue.database_name
}

output "athena_workgroup_name" {
  description = "Athena workgroup configured to write query results into the same bucket's athena-results/ prefix."
  value       = module.athena.workgroup_name
}
