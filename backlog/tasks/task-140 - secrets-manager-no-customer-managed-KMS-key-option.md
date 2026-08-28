---
id: TASK-140
title: 'secrets-manager: no customer-managed KMS key option'
status: Done
assignee: []
created_date: '2026-08-28 04:30'
updated_date: '2026-08-28 04:40'
labels: []
milestone: m-17
dependencies: []
type: bug
ordinal: 302000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
checkov CKV_AWS_149 / trivy AWS-0098 — secret uses the AWS-managed key. Add optional kms_key_arn variable.
<!-- SECTION:DESCRIPTION:END -->

## Final Summary

<!-- SECTION:FINAL_SUMMARY:BEGIN -->
Added optional kms_key_arn variable, wired into aws_secretsmanager_secret.kms_key_id. validate passes.
<!-- SECTION:FINAL_SUMMARY:END -->
