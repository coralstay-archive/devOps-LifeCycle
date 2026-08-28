---
id: TASK-133
title: 'dms: no customer-managed KMS key option'
status: Done
assignee: []
created_date: '2026-08-28 04:29'
updated_date: '2026-08-28 04:40'
labels: []
milestone: m-17
dependencies: []
type: bug
ordinal: 295000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
checkov CKV_AWS_296/CKV_AWS_212 — replication instance and endpoints only support the AWS-managed aws/dms key; no variable exists to pass a CMK. Add optional kms_key_arn, wire into aws_dms_replication_instance.kms_key_arn and aws_dms_endpoint.*.kms_key_arn.
<!-- SECTION:DESCRIPTION:END -->

## Final Summary

<!-- SECTION:FINAL_SUMMARY:BEGIN -->
Added optional kms_key_arn variable (default null), wired into aws_dms_replication_instance.kms_key_arn and both aws_dms_endpoint (source/target) kms_key_arn. terraform-docs refreshed, validate passes.
<!-- SECTION:FINAL_SUMMARY:END -->
