module "state_bucket" {
  source = "../modules/s3-bucket"

  bucket_name        = var.state_bucket_name
  versioning_enabled = true
  force_destroy      = false
}
