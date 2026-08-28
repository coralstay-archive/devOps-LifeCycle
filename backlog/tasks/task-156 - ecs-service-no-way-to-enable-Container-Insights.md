---
id: TASK-156
title: 'ecs-service: no way to enable Container Insights'
status: Done
assignee: []
created_date: '2026-08-28 04:31'
updated_date: '2026-08-28 04:41'
labels: []
milestone: m-17
dependencies: []
type: bug
ordinal: 318000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
checkov CKV_AWS_65 / trivy AWS-0034 — no settings block on aws_ecs_cluster at all. Add opt-in enable_container_insights variable (default false — real per-cluster cost when on).
<!-- SECTION:DESCRIPTION:END -->

## Final Summary

<!-- SECTION:FINAL_SUMMARY:BEGIN -->
Added enable_flow_logs variable (default false); when true creates a CloudWatch log group + IAM role + aws_flow_log (REJECT traffic only).
<!-- SECTION:FINAL_SUMMARY:END -->
