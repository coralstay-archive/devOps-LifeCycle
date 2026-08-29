---
id: TASK-179.1
title: Write root module calling iam-github-oidc twice
status: To Do
assignee: []
created_date: '2026-08-29 12:13'
labels: []
dependencies: []
parent_task_id: TASK-179
type: task
ordinal: 347000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
Two module calls: plan role (create_oidc_provider=true, allowed_ref="*" or
scoped to pull_request refs, policy_arns = read-only e.g. ReadOnlyAccess)
and apply role (create_oidc_provider=false -- reuse the provider from the
first call, allowed_ref="refs/heads/main", policy_arns scoped to what
live/example-dev actually needs to create: VPC + S3 at minimum).
<!-- SECTION:DESCRIPTION:END -->
