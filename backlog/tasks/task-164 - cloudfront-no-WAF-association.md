---
id: TASK-164
title: 'cloudfront: no WAF association'
status: Done
assignee: []
created_date: '2026-08-28 04:32'
updated_date: '2026-08-28 09:20'
labels: []
milestone: m-17
dependencies: []
type: bug
ordinal: 326000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
checkov CKV_AWS_68 / trivy AWS-0011 — this repo already has modules/waf-shield; add an optional web_acl_id variable to wire it in rather than building new WAF logic.
<!-- SECTION:DESCRIPTION:END -->

## Final Summary

<!-- SECTION:FINAL_SUMMARY:BEGIN -->
Added web_acl_id variable (default null), wired into aws_cloudfront_distribution.web_acl_id -- lets a scenario pass in a waf-shield CLOUDFRONT-scope ACL.
<!-- SECTION:FINAL_SUMMARY:END -->
