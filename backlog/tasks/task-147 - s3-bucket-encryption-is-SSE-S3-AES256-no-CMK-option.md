---
id: TASK-147
title: 's3-bucket: encryption is SSE-S3 (AES256), no CMK option'
status: Done
assignee: []
created_date: '2026-08-28 04:30'
updated_date: '2026-08-28 04:40'
labels: []
milestone: m-17
dependencies: []
type: bug
ordinal: 309000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
trivy AWS-0132 — server_side_encryption_configuration hardcodes AES256. Add optional kms_key_arn variable that switches sse_algorithm to aws:kms when set.
<!-- SECTION:DESCRIPTION:END -->

## Final Summary

<!-- SECTION:FINAL_SUMMARY:BEGIN -->
Added optional kms_key_arn variable, wired into aws_backup_vault.kms_key_arn (confirmed optional+computed in provider schema). validate passes.
<!-- SECTION:FINAL_SUMMARY:END -->
