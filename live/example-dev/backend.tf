# Remote state backend. The bucket referenced here is NOT created by this
# stack — it must exist before `terraform init` works. Bootstrap it once
# (see bootstrap/README.md) using modules/s3-bucket (versioning_enabled = true).
#
# State locking is S3-native (use_lockfile, Terraform >= 1.11) — no DynamoDB
# table needed. See bootstrap/README.md for why.
#
# Fill in the placeholder below with your actual bucket name before running init.
terraform {
  backend "s3" {
    bucket       = "CHANGE-ME-aws-launcher-tfstate"
    key          = "example-dev/terraform.tfstate"
    region       = "ap-northeast-2"
    use_lockfile = true
    encrypt      = true
  }
}
