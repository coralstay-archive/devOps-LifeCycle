---
id: TASK-148
title: 'elasticache-redis: no transit encryption or AUTH token'
status: Done
assignee: []
created_date: '2026-08-28 04:31'
updated_date: '2026-08-28 04:41'
labels: []
milestone: m-17
dependencies: []
type: bug
ordinal: 310000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
checkov CKV_AWS_31 / trivy — replication group has no transit_encryption_enabled/auth_token, meaning traffic is unauthenticated plaintext. Add auth_token (sensitive, optional) + transit_encryption_enabled=true when set.
<!-- SECTION:DESCRIPTION:END -->

## Final Summary

<!-- SECTION:FINAL_SUMMARY:BEGIN -->
Added sensitive auth_token variable wired to aws_elasticache_replication_group.auth_token; transit_encryption_enabled was already true.
<!-- SECTION:FINAL_SUMMARY:END -->
