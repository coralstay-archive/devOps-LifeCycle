---
id: TASK-169
title: 'api-gateway: routes have no authorization type'
status: Done
assignee: []
created_date: '2026-08-28 04:32'
updated_date: '2026-08-28 10:03'
labels: []
milestone: m-17
dependencies: []
type: bug
ordinal: 331000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
checkov CKV_AWS_309 — intentionally open by default for a scaffold; before adding, decide whether to force an authorizer_id variable (breaking for existing callers) or just document as an explicit opt-in. Needs a design decision, not just code.
<!-- SECTION:DESCRIPTION:END -->

## Final Summary

<!-- SECTION:FINAL_SUMMARY:BEGIN -->
Added authorization_type (default NONE, preserving original behavior) and authorizer_id variables, wired into aws_apigatewayv2_route. Non-breaking since default matches prior behavior exactly -- not the breaking design decision originally worried about. Added a precondition requiring authorizer_id when authorization_type is JWT/CUSTOM.
<!-- SECTION:FINAL_SUMMARY:END -->
