---
id: TASK-167
title: 'alb: no access logging option'
status: Done
assignee: []
created_date: '2026-08-28 04:32'
updated_date: '2026-08-28 09:26'
labels: []
milestone: m-17
dependencies: []
type: bug
ordinal: 329000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
checkov CKV_AWS_91 — needs a real S3 bucket (can compose modules/s3-bucket) plus the ALB-specific bucket policy. Bigger lift, same shape as the cloudfront logging gap.
<!-- SECTION:DESCRIPTION:END -->

## Final Summary

<!-- SECTION:FINAL_SUMMARY:BEGIN -->
Added access_logs_bucket/access_logs_prefix variables (both default null), wired into a dynamic access_logs block on aws_lb. Module still doesn't create the destination bucket itself -- needs the ELB service account's log-delivery bucket policy, which is shared account-level infra, not something one ALB should own.
<!-- SECTION:FINAL_SUMMARY:END -->
