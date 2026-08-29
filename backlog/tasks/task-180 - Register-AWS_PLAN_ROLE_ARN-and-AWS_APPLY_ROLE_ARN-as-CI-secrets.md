---
id: TASK-180
title: Register AWS_PLAN_ROLE_ARN and AWS_APPLY_ROLE_ARN as CI secrets
status: To Do
assignee: []
created_date: '2026-08-29 12:14'
updated_date: '2026-08-29 12:32'
labels: []
milestone: m-19
dependencies:
  - TASK-179
type: task
ordinal: 349000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
Register both role ARNs as GitHub repo secrets on amosQP/aws-launcher, same pattern as INFRACOST_API_KEY: run `gh secret set` directly (not through an assistant/chat) so the value never lands anywhere it could be logged.
<!-- SECTION:DESCRIPTION:END -->
