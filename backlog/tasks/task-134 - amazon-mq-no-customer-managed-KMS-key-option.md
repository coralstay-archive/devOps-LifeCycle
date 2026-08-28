---
id: TASK-134
title: 'amazon-mq: no customer-managed KMS key option'
status: Done
assignee: []
created_date: '2026-08-28 04:29'
updated_date: '2026-08-28 04:40'
labels: []
milestone: m-17
dependencies: []
type: bug
ordinal: 296000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
checkov CKV_AWS_209 — broker uses AWS default encryption; add optional kms_key_arn variable wired to aws_mq_broker.encryption_options.
<!-- SECTION:DESCRIPTION:END -->

## Final Summary

<!-- SECTION:FINAL_SUMMARY:BEGIN -->
Added optional kms_key_arn variable (default null), wired into aws_mq_broker.encryption_options (use_aws_owned_key when unset). validate passes.
<!-- SECTION:FINAL_SUMMARY:END -->
