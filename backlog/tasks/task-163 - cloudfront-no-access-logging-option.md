---
id: TASK-163
title: 'cloudfront: no access logging option'
status: Done
assignee: []
created_date: '2026-08-28 04:32'
updated_date: '2026-08-28 09:28'
labels: []
milestone: m-17
dependencies: []
type: bug
ordinal: 325000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
checkov CKV_AWS_86 / trivy AWS-0010 — needs a real S3 bucket to log to (can compose modules/s3-bucket). Bigger lift than a toggle since it's cross-module wiring, not just a new argument.
<!-- SECTION:DESCRIPTION:END -->

## Final Summary

<!-- SECTION:FINAL_SUMMARY:BEGIN -->
Added logging_bucket_domain_name/logging_prefix variables (both default null), wired into a dynamic logging_config block. Same bring-your-own-bucket pattern as alb's access_logs_bucket -- doesn't create/configure the destination bucket itself.
<!-- SECTION:FINAL_SUMMARY:END -->
