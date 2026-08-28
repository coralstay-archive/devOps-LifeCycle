---
id: TASK-166
title: 'cloudfront: no origin failover'
status: Done
assignee: []
created_date: '2026-08-28 04:32'
updated_date: '2026-08-28 14:11'
labels: []
milestone: m-17
dependencies: []
type: bug
ordinal: 328000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
checkov CKV_AWS_310 — needs an origin_group with a second origin; real architectural addition, not a toggle. Lower priority — most scenarios using this module have one origin by design.
<!-- SECTION:DESCRIPTION:END -->

## Final Summary

<!-- SECTION:FINAL_SUMMARY:BEGIN -->
Added failover_origin_domain_name variable (default null), wired into a dynamic second origin + origin_group (403/404/5xx failover criteria), and switched default_cache_behavior.target_origin_id to the origin_group when set. Reuses the existing OAC for both origins since it's a generic signing config, not bucket-specific.
<!-- SECTION:FINAL_SUMMARY:END -->
