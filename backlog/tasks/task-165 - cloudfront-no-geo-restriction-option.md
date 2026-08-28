---
id: TASK-165
title: 'cloudfront: no geo restriction option'
status: Done
assignee: []
created_date: '2026-08-28 04:32'
updated_date: '2026-08-28 09:20'
labels: []
milestone: m-17
dependencies: []
type: bug
ordinal: 327000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
checkov CKV_AWS_374 — add opt-in geo_restriction_type/locations variables (cheap, no new resource needed).
<!-- SECTION:DESCRIPTION:END -->

## Final Summary

<!-- SECTION:FINAL_SUMMARY:BEGIN -->
Added geo_restriction_type (default none) and geo_restriction_locations variables, wired into the existing restrictions.geo_restriction block.
<!-- SECTION:FINAL_SUMMARY:END -->
