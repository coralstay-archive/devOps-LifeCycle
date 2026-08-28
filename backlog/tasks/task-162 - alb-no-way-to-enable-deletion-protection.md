---
id: TASK-162
title: 'alb: no way to enable deletion protection'
status: Done
assignee: []
created_date: '2026-08-28 04:31'
updated_date: '2026-08-28 04:40'
labels: []
milestone: m-17
dependencies: []
type: bug
ordinal: 324000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
checkov CKV_AWS_150 — enable_deletion_protection isn't set/exposed. Add opt-in enable_deletion_protection variable (default false to keep scaffolding easy to tear down).
<!-- SECTION:DESCRIPTION:END -->

## Final Summary

<!-- SECTION:FINAL_SUMMARY:BEGIN -->
Added enable_deletion_protection variable (default false), wired to aws_lb.this.enable_deletion_protection.
<!-- SECTION:FINAL_SUMMARY:END -->
