# Remote state backend. The bucket and DynamoDB lock table referenced here are
# NOT created by this stack — they must exist before `terraform init` works.
# Bootstrap them once (manually, or via a one-off bootstrap stack) using:
#   modules/s3-bucket (with versioning_enabled = true) for the bucket
#   a DynamoDB table with hash key "LockID" (String) for locking
#
# Fill in the placeholders below with your actual bucket/table names before running init.
terraform {
  backend "s3" {
    bucket         = "CHANGE-ME-aws-launcher-tfstate"
    key            = "example-dev/terraform.tfstate"
    region         = "ap-northeast-2"
    dynamodb_table = "CHANGE-ME-aws-launcher-tf-locks"
    encrypt        = true
  }
}
