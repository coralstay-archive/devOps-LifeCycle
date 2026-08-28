---
id: TASK-139
title: 'redshift: no customer-managed KMS key option'
status: Done
assignee: []
created_date: '2026-08-28 04:30'
updated_date: '2026-08-28 04:39'
labels: []
milestone: m-17
dependencies: []
type: bug
ordinal: 301000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
checkov CKV_AWS_142 / trivy AWS-0084 — cluster isn't encrypted at all by default (encrypted defaults to false for aws_redshift_cluster). Add optional kms_key_arn variable; set encrypted=true whenever it's supplied, document the default-unencrypted trade-off otherwise.
<!-- SECTION:DESCRIPTION:END -->

## Final Summary

<!-- SECTION:FINAL_SUMMARY:BEGIN -->
Added kms_key_arn to redshift (default null, falls back to AWS-managed aws/redshift key — module already had encrypted=true, contrary to the task's initial premise).
<!-- SECTION:FINAL_SUMMARY:END -->
