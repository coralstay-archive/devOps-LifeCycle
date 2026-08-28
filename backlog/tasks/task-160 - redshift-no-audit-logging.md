---
id: TASK-160
title: 'redshift: no audit logging'
status: Done
assignee: []
created_date: '2026-08-28 04:31'
updated_date: '2026-08-28 04:39'
labels: []
milestone: m-17
dependencies: []
type: bug
ordinal: 322000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
checkov CKV_AWS_71 — no logging block on aws_redshift_cluster. Add opt-in logging_bucket_name/logging_s3_key_prefix variables wired to a logging block.
<!-- SECTION:DESCRIPTION:END -->

## Final Summary

<!-- SECTION:FINAL_SUMMARY:BEGIN -->
Added logging_bucket_name/logging_s3_key_prefix variables + dynamic logging block to aws_redshift_cluster.
<!-- SECTION:FINAL_SUMMARY:END -->
