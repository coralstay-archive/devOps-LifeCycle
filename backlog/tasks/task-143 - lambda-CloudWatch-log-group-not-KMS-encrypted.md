---
id: TASK-143
title: 'lambda: CloudWatch log group not KMS-encrypted'
status: Done
assignee: []
created_date: '2026-08-28 04:30'
updated_date: '2026-08-28 04:40'
labels: []
milestone: m-17
dependencies: []
type: bug
ordinal: 305000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
trivy AWS-0017 — Lambda's log group has no kms_key_id. Add optional log_kms_key_arn variable wired to the aws_cloudwatch_log_group resource.
<!-- SECTION:DESCRIPTION:END -->

## Final Summary

<!-- SECTION:FINAL_SUMMARY:BEGIN -->
Added log_kms_key_arn variable, wired to the lambda log group's kms_key_id. Default null preserves prior behavior.
<!-- SECTION:FINAL_SUMMARY:END -->
