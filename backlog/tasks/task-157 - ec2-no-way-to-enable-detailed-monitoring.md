---
id: TASK-157
title: 'ec2: no way to enable detailed monitoring'
status: Done
assignee: []
created_date: '2026-08-28 04:31'
updated_date: '2026-08-28 04:39'
labels: []
milestone: m-17
dependencies: []
type: bug
ordinal: 319000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
checkov CKV_AWS_126 — monitoring isn't set on aws_instance. Add opt-in enable_detailed_monitoring variable (default false — real per-instance cost when on).
<!-- SECTION:DESCRIPTION:END -->

## Final Summary

<!-- SECTION:FINAL_SUMMARY:BEGIN -->
log_exports variable now on by default with a documented cost trade-off note; opt out with an empty list.
<!-- SECTION:FINAL_SUMMARY:END -->
