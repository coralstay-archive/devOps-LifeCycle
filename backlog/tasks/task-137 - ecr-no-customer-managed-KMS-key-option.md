---
id: TASK-137
title: 'ecr: no customer-managed KMS key option'
status: Done
assignee: []
created_date: '2026-08-28 04:30'
updated_date: '2026-08-28 04:40'
labels: []
milestone: m-17
dependencies: []
type: bug
ordinal: 299000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
checkov CKV_AWS_136 / trivy AWS-0033 — repository uses default AES256, no CMK option. Add optional kms_key_arn, switch encryption_type to KMS when set.
<!-- SECTION:DESCRIPTION:END -->

## Final Summary

<!-- SECTION:FINAL_SUMMARY:BEGIN -->
Added optional kms_key_arn variable; encryption_configuration now switches encryption_type to KMS automatically when set, AES256 otherwise. validate passes.
<!-- SECTION:FINAL_SUMMARY:END -->
