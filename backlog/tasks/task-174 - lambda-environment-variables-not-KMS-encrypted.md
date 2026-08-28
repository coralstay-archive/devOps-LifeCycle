---
id: TASK-174
title: 'lambda: environment variables not KMS-encrypted'
status: Done
assignee: []
created_date: '2026-08-28 04:32'
updated_date: '2026-08-28 04:40'
labels: []
milestone: m-17
dependencies: []
type: bug
ordinal: 336000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
checkov CKV_AWS_173 — add optional kms_key_arn variable wired to aws_lambda_function.kms_key_arn.
<!-- SECTION:DESCRIPTION:END -->

## Final Summary

<!-- SECTION:FINAL_SUMMARY:BEGIN -->
Added kms_key_arn variable wired to aws_lambda_function.this.kms_key_arn for env var encryption.
<!-- SECTION:FINAL_SUMMARY:END -->
