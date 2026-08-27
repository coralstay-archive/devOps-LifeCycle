# bootstrap

One-time stack that creates the S3 bucket every other stack's `backend.tf` points at for remote state.

## Why this is separate from `live/`

This stack has to manage its own state **locally** (no `backend` block) because it's what creates the remote backend in the first place — a chicken-and-egg problem. Run it once per AWS account/region, then never touch it again except to inspect it.

## State locking: S3-native, no DynamoDB

This stack does **not** create a DynamoDB lock table. As of Terraform 1.11, the S3 backend supports native locking via `use_lockfile = true` (S3 conditional writes) — DynamoDB-based locking (`dynamodb_table`) is now deprecated. One less resource to manage, and no DynamoDB read/write costs. Requires Terraform >= 1.11 in anything consuming this backend (see `live/example-dev/versions.tf`).

## Usage

```
cd bootstrap
terraform init
terraform apply -var="state_bucket_name=<your-globally-unique-name>"
```

Then copy the resulting bucket name into the `backend.tf` of any `live/<project>` stack (it currently has a `CHANGE-ME-*` placeholder).

## Status

Implemented (minimal).
