---
id: TASK-161
title: 'redshift: enhanced VPC routing not enabled'
status: Done
assignee: []
created_date: '2026-08-28 04:31'
updated_date: '2026-08-28 04:39'
labels: []
milestone: m-17
dependencies: []
type: bug
ordinal: 323000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
checkov CKV_AWS_321 — enhanced_vpc_routing is unset (defaults false). Add as a variable, default true (free — just routes cluster traffic through the VPC instead of the public internet, no cost difference).
<!-- SECTION:DESCRIPTION:END -->

## Final Summary

<!-- SECTION:FINAL_SUMMARY:BEGIN -->
Added enhanced_vpc_routing variable, default true (free).
<!-- SECTION:FINAL_SUMMARY:END -->
