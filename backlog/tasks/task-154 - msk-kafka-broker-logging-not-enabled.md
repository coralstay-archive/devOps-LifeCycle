---
id: TASK-154
title: 'msk-kafka: broker logging not enabled'
status: Done
assignee: []
created_date: '2026-08-28 04:31'
updated_date: '2026-08-28 04:40'
labels: []
milestone: m-17
dependencies: []
type: bug
ordinal: 316000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
checkov CKV_AWS_80 / trivy AWS-0074 — no logging_info block on aws_msk_cluster. Add CloudWatch broker logging (new log group + logging_info block).
<!-- SECTION:DESCRIPTION:END -->

## Final Summary

<!-- SECTION:FINAL_SUMMARY:BEGIN -->
Added encryption_at_rest_kms_key_arn variable (default null — MSK applies its own AWS-managed key automatically when unset).
<!-- SECTION:FINAL_SUMMARY:END -->
