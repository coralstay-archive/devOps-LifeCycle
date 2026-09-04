---
id: TASK-182.1
title: Add environment condition to modules/iam-github-oidc trust policy
status: To Do
assignee: []
created_date: '2026-08-29 12:15'
labels: []
dependencies: []
parent_task_id: TASK-182
type: task
ordinal: 357000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
Extend the module's trust policy (currently only checks aud + sub:ref) with an additional condition on the environment claim, gated behind a variable so the ref-only behavior stays the default for callers that don't use GitHub Environments.
<!-- SECTION:DESCRIPTION:END -->
