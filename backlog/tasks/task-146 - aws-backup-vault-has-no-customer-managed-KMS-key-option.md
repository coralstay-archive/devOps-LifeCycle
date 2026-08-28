---
id: TASK-146
title: 'aws-backup: vault has no customer-managed KMS key option'
status: Done
assignee: []
created_date: '2026-08-28 04:30'
updated_date: '2026-08-28 04:39'
labels: []
milestone: m-17
dependencies: []
type: bug
ordinal: 308000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
checkov CKV_AWS_166 — backup vault uses the default AWS-managed key. Add optional kms_key_arn variable.
<!-- SECTION:DESCRIPTION:END -->

## Final Summary

<!-- SECTION:FINAL_SUMMARY:BEGIN -->
Added kms_key_arn to s3-bucket; switches sse_algorithm to aws:kms when set, defaults to AES256.
<!-- SECTION:FINAL_SUMMARY:END -->
