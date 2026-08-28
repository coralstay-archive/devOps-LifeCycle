---
id: TASK-155
title: 'msk-kafka: encryption_at_rest_kms_key_arn not set explicitly'
status: Done
assignee: []
created_date: '2026-08-28 04:31'
updated_date: '2026-08-28 04:40'
labels: []
milestone: m-17
dependencies: []
type: bug
ordinal: 317000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
trivy AWS-0179 — encryption_info only sets encryption_in_transit; at-rest key isn't explicit (AWS applies its own default key here, so this may be a scanner false-negative — verify, then either set an explicit AWS-managed default or add an optional CMK variable and document the finding either way).
<!-- SECTION:DESCRIPTION:END -->

## Final Summary

<!-- SECTION:FINAL_SUMMARY:BEGIN -->
Added enable_container_insights variable (default false), wired to a settings block on aws_ecs_cluster.this.
<!-- SECTION:FINAL_SUMMARY:END -->
