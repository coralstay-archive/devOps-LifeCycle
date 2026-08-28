---
id: TASK-159
title: 'rds-postgres: no CloudWatch log exports configured'
status: To Do
assignee: []
created_date: '2026-08-28 04:31'
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
