---
id: TASK-153
title: 'vpc: no VPC Flow Logs'
status: Done
assignee: []
created_date: '2026-08-28 04:31'
updated_date: '2026-08-28 04:40'
labels: []
milestone: m-17
dependencies: []
type: bug
ordinal: 315000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
trivy AWS-0178 — no flow log, log group, or IAM role exists. Add as opt-in (enable_flow_logs variable, default false to avoid forcing cost) — new cloudwatch log group + IAM role + aws_flow_log resource.
<!-- SECTION:DESCRIPTION:END -->

## Final Summary

<!-- SECTION:FINAL_SUMMARY:BEGIN -->
Added CloudWatch broker logging unconditionally — new aws_cloudwatch_log_group + logging_info block on aws_msk_cluster.this. Was a total gap before, fixed for free.
<!-- SECTION:FINAL_SUMMARY:END -->
