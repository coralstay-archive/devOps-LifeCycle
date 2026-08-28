---
id: TASK-142
title: 'observability: SNS alarm topic has no CMK option'
status: Done
assignee: []
created_date: '2026-08-28 04:30'
updated_date: '2026-08-28 04:39'
labels: []
milestone: m-17
dependencies: []
type: bug
ordinal: 304000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
trivy AWS-0136 — alarms topic uses alias/aws/sns. Add optional kms_key_arn variable.
<!-- SECTION:DESCRIPTION:END -->

## Final Summary

<!-- SECTION:FINAL_SUMMARY:BEGIN -->
Added kms_key_arn to observability's alarms SNS topic, same coalesce() fallback pattern.
<!-- SECTION:FINAL_SUMMARY:END -->
