---
id: TASK-158
title: 'rds-postgres: enhanced monitoring not available'
status: Done
assignee: []
created_date: '2026-08-28 04:31'
updated_date: '2026-08-28 04:40'
labels: []
milestone: m-17
dependencies: []
type: bug
ordinal: 320000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
checkov CKV_AWS_118 — no monitoring_interval/monitoring_role_arn. Needs a new IAM role (assumable by monitoring.rds.amazonaws.com) plus an opt-in monitoring_interval variable — bigger lift than the other toggles since it requires a new IAM resource.
<!-- SECTION:DESCRIPTION:END -->

## Final Summary

<!-- SECTION:FINAL_SUMMARY:BEGIN -->
Added enable_detailed_monitoring variable (default false), wired to aws_instance.this.monitoring.
<!-- SECTION:FINAL_SUMMARY:END -->
