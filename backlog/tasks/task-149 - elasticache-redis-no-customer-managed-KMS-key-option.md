---
id: TASK-149
title: 'elasticache-redis: no customer-managed KMS key option'
status: Done
assignee: []
created_date: '2026-08-28 04:31'
updated_date: '2026-08-28 04:41'
labels: []
milestone: m-17
dependencies: []
type: bug
ordinal: 311000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
checkov CKV_AWS_191 — at-rest encryption (if enabled) uses AWS-managed key. Add optional kms_key_arn variable.
<!-- SECTION:DESCRIPTION:END -->

## Final Summary

<!-- SECTION:FINAL_SUMMARY:BEGIN -->
Added kms_key_arn variable wired to kms_key_id; at_rest_encryption_enabled was already true.
<!-- SECTION:FINAL_SUMMARY:END -->
