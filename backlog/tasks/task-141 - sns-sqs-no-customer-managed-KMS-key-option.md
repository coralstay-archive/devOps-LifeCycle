---
id: TASK-141
title: 'sns-sqs: no customer-managed KMS key option'
status: Done
assignee: []
created_date: '2026-08-28 04:30'
updated_date: '2026-08-28 04:39'
labels: []
milestone: m-17
dependencies: []
type: bug
ordinal: 303000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
trivy AWS-0135/AWS-0136 — topic and queue use alias/aws/sns and alias/aws/sqs. Add optional kms_key_arn variable(s) to override with a CMK.
<!-- SECTION:DESCRIPTION:END -->

## Final Summary

<!-- SECTION:FINAL_SUMMARY:BEGIN -->
Added shared kms_key_arn variable to sns-sqs, wired via coalesce() fallback to alias/aws/sns and alias/aws/sqs.
<!-- SECTION:FINAL_SUMMARY:END -->
