---
id: TASK-168
title: 'api-gateway: no access logging option'
status: Done
assignee: []
created_date: '2026-08-28 04:32'
updated_date: '2026-08-28 09:24'
labels: []
milestone: m-17
dependencies: []
type: bug
ordinal: 330000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
checkov CKV_AWS_76 / trivy AWS-0001 — needs a new CloudWatch log group + stage access_log_settings. Moderate lift.
<!-- SECTION:DESCRIPTION:END -->

## Final Summary

<!-- SECTION:FINAL_SUMMARY:BEGIN -->
Added unconditional aws_cloudwatch_log_group + access_log_settings on the $default stage (log_retention_days variable, default 14). Total gap before -- no log group existed at all -- so fixed for free rather than opt-in.
<!-- SECTION:FINAL_SUMMARY:END -->
