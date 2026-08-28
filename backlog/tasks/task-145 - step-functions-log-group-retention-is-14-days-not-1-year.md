---
id: TASK-145
title: 'step-functions: log group retention is 14 days, not 1 year'
status: Done
assignee: []
created_date: '2026-08-28 04:30'
updated_date: '2026-08-28 04:40'
labels: []
milestone: m-17
dependencies: []
type: bug
ordinal: 307000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
checkov CKV_AWS_338 — matches Lambda's convention but checkov wants >=365d for state-machine logs specifically. Add a retention_days variable (default 14, documented) instead of hardcoding.
<!-- SECTION:DESCRIPTION:END -->

## Final Summary

<!-- SECTION:FINAL_SUMMARY:BEGIN -->
Added log_retention_days variable (default 14), replaced the hardcoded retention_in_days.
<!-- SECTION:FINAL_SUMMARY:END -->
