---
id: TASK-136
title: 'dynamodb: no customer-managed KMS key option'
status: Done
assignee: []
created_date: '2026-08-28 04:30'
updated_date: '2026-08-28 04:40'
labels: []
milestone: m-17
dependencies: []
type: bug
ordinal: 298000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
checkov CKV_AWS_119 / trivy AWS-0025 — table encryption has no CMK option. Add optional kms_key_arn, wire into server_side_encryption block.
<!-- SECTION:DESCRIPTION:END -->

## Final Summary

<!-- SECTION:FINAL_SUMMARY:BEGIN -->
Added optional kms_key_arn variable, wired into server_side_encryption.kms_key_arn on aws_dynamodb_table. validate passes.
<!-- SECTION:FINAL_SUMMARY:END -->
