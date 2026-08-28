---
id: TASK-152
title: 'eks: public endpoint CIDR is not configurable'
status: Done
assignee: []
created_date: '2026-08-28 04:31'
updated_date: '2026-08-28 04:41'
labels: []
milestone: m-17
dependencies: []
type: bug
ordinal: 314000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
checkov CKV_AWS_38/CKV_AWS_39 / trivy AWS-0040/AWS-0041 — public_access is open to 0.0.0.0/0 with no way to restrict it. Add a public_access_cidrs variable (default ["0.0.0.0/0"] to preserve current behavior, but now controllable).
<!-- SECTION:DESCRIPTION:END -->

## Final Summary

<!-- SECTION:FINAL_SUMMARY:BEGIN -->
Added public_access_cidrs variable (default ["0.0.0.0/0"], preserves current behavior but now controllable) wired to vpc_config.
<!-- SECTION:FINAL_SUMMARY:END -->
