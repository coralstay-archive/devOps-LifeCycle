---
id: TASK-138
title: 'rds-postgres: Performance Insights has no CMK option'
status: Done
assignee: []
created_date: '2026-08-28 04:30'
updated_date: '2026-08-28 04:39'
labels: []
milestone: m-17
dependencies: []
type: bug
ordinal: 300000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
checkov CKV_AWS_354 / trivy AWS-0078 — performance_insights_enabled is on but uses the AWS-managed key. Add optional performance_insights_kms_key_id variable.
<!-- SECTION:DESCRIPTION:END -->

## Final Summary

<!-- SECTION:FINAL_SUMMARY:BEGIN -->
Added performance_insights_kms_key_id (default null) + log_exports (default [postgresql, upgrade]) to rds-postgres, wired into aws_db_instance.
<!-- SECTION:FINAL_SUMMARY:END -->
