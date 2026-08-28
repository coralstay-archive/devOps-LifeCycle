---
id: TASK-172
title: 'lambda: no reserved concurrency limit option'
status: Done
assignee: []
created_date: '2026-08-28 04:32'
updated_date: '2026-08-28 04:40'
labels: []
milestone: m-17
dependencies: []
type: bug
ordinal: 334000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
checkov CKV_AWS_115 — add opt-in reserved_concurrent_executions variable.
<!-- SECTION:DESCRIPTION:END -->

## Final Summary

<!-- SECTION:FINAL_SUMMARY:BEGIN -->
Added dead_letter_target_arn variable + dynamic dead_letter_config block on aws_lambda_function.this.
<!-- SECTION:FINAL_SUMMARY:END -->
