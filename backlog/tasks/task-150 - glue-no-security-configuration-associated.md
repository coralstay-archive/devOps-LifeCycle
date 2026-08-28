---
id: TASK-150
title: 'glue: no security configuration associated'
status: Done
assignee: []
created_date: '2026-08-28 04:31'
updated_date: '2026-08-28 04:41'
labels: []
milestone: m-17
dependencies: []
type: bug
ordinal: 312000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
checkov CKV_AWS_195 — no aws_glue_security_configuration exists at all, so job bookmarks/CloudWatch logs/S3 targets have no enforced encryption. Add the resource (optional CMK) and wire security_configuration into the Glue job.
<!-- SECTION:DESCRIPTION:END -->

## Final Summary

<!-- SECTION:FINAL_SUMMARY:BEGIN -->
Added aws_glue_security_configuration (CloudWatch/job-bookmarks/S3 modes gated on new kms_key_arn variable) and wired it into the crawler's security_configuration argument.
<!-- SECTION:FINAL_SUMMARY:END -->
