---
id: decision-1
title: DynamoDB 락 대신 S3 네이티브 락(use_lockfile) 채택
date: '2026-08-27 05:05'
status: accepted
---
## Context

Terraform state locking for the S3 backend traditionally required a separate DynamoDB table (`dynamodb_table` argument) to prevent concurrent `apply` operations from corrupting state. As of Terraform 1.11, the S3 backend supports native locking via `use_lockfile = true` (S3 conditional writes), and HashiCorp has deprecated the DynamoDB-based locking arguments — they still work but emit warnings and will be removed in a future minor version.

## Decision

`bootstrap/` no longer creates a DynamoDB lock table. `live/*` stacks use `use_lockfile = true` in their `backend "s3"` block instead, and pin `required_version = ">= 1.11"` so the version requirement fails loudly instead of surfacing as a confusing backend-argument error on older Terraform.

## Consequences

- One fewer AWS resource to provision/pay for per environment (no DynamoDB read/write capacity).
- Anyone applying a `live/*` stack needs Terraform >= 1.11 locally and in CI (`hashicorp/setup-terraform` is unpinned in our workflows, so this resolves automatically to latest — worth revisiting if that ever changes).
- `bootstrap/`'s own state is local-only (chicken-and-egg — it creates the backend), so this decision doesn't apply to `bootstrap/` itself, only to what it produces for others to consume.

