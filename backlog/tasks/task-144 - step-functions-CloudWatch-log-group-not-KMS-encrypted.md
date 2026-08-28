---
id: TASK-144
title: 'step-functions: CloudWatch log group not KMS-encrypted'
status: Done
assignee: []
created_date: '2026-08-28 04:30'
updated_date: '2026-08-28 04:40'
labels: []
milestone: m-17
dependencies: []
type: bug
ordinal: 306000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
checkov CKV_AWS_158 / trivy AWS-0017 — the state machine's log group (added for logging_configuration) has no kms_key_id. Add optional log_kms_key_arn variable.
<!-- SECTION:DESCRIPTION:END -->

## Final Summary

<!-- SECTION:FINAL_SUMMARY:BEGIN -->
Added log_kms_key_arn variable, wired to the step-functions log group's kms_key_id.
<!-- SECTION:FINAL_SUMMARY:END -->
