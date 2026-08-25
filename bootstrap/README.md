# bootstrap

One-time stack that creates the S3 bucket + DynamoDB lock table every other stack's `backend.tf` points at.

## Why this is separate from `live/`

This stack has to manage its own state **locally** (no `backend` block) because it's what creates the remote backend in the first place — a chicken-and-egg problem. Run it once per AWS account/region, then never touch it again except to inspect it.

## Usage

```
cd bootstrap
terraform init
terraform apply -var="state_bucket_name=<your-globally-unique-name>"
```

Then copy the resulting bucket/table names into the `backend.tf` of any `live/<project>` stack (they currently have `CHANGE-ME-*` placeholders).

## Status

Implemented (minimal).
