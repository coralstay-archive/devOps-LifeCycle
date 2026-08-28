---
id: TASK-170
title: 'lambda: no VPC attachment option'
status: Done
assignee: []
created_date: '2026-08-28 04:32'
updated_date: '2026-08-28 09:58'
labels: []
milestone: m-17
dependencies: []
type: bug
ordinal: 332000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
checkov CKV_AWS_117 — no vpc_config. Needs new subnet_ids/security_group_ids variables plus ENI creation implications (cold start latency trade-off) — document that trade-off alongside the fix.
<!-- SECTION:DESCRIPTION:END -->

## Final Summary

<!-- SECTION:FINAL_SUMMARY:BEGIN -->
Added subnet_ids/security_group_ids variables (both default []), wired into a dynamic vpc_config block, plus a count-gated AWSLambdaVPCAccessExecutionRole policy attachment and depends_on ordering. Documented the cold-start latency trade-off in the README.
<!-- SECTION:FINAL_SUMMARY:END -->
