---
id: TASK-159
title: 'rds-postgres: no CloudWatch log exports configured'
status: Done
assignee: []
created_date: '2026-08-28 04:31'
updated_date: '2026-08-28 09:17'
labels: []
milestone: m-17
dependencies: []
type: bug
ordinal: 321000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
checkov CKV_AWS_129 — enabled_cloudwatch_logs_exports is unset. Add opt-in log_exports variable (list of log types, e.g. ["postgresql", "upgrade"]).
<!-- SECTION:DESCRIPTION:END -->

## Final Summary

<!-- SECTION:FINAL_SUMMARY:BEGIN -->
Added log_exports variable (default ["postgresql","upgrade"]), wired into enabled_cloudwatch_logs_exports. Implemented by the rds-postgres/redshift fork, but incorrectly recorded against TASK-157 due to a task-ID mislabeling in the coordinating session's fork instructions -- corrected here.
<!-- SECTION:FINAL_SUMMARY:END -->
