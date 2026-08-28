---
id: TASK-151
title: 'eks: control plane logging entirely disabled'
status: Done
assignee: []
created_date: '2026-08-28 04:31'
updated_date: '2026-08-28 04:41'
labels: []
milestone: m-17
dependencies: []
type: bug
ordinal: 313000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
checkov CKV_AWS_37 / trivy AWS-0038 (all 5 log types) — enabled_cluster_log_types is unset. Add it (api, audit, authenticator, controllerManager, scheduler) — note ongoing CloudWatch Logs cost, document as opt-in via a variable defaulting to enabled types list, empty list = current behavior.
<!-- SECTION:DESCRIPTION:END -->

## Final Summary

<!-- SECTION:FINAL_SUMMARY:BEGIN -->
Added cluster_log_types variable (default []) wired to enabled_cluster_log_types.
<!-- SECTION:FINAL_SUMMARY:END -->
