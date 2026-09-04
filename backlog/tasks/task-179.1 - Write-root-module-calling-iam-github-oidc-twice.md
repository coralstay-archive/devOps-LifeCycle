---
id: TASK-179.1
title: Write root module calling iam-github-oidc for the plan role
status: To Do
assignee: []
created_date: '2026-08-29 12:13'
updated_date: '2026-09-04 15:09'
labels: []
dependencies: []
parent_task_id: TASK-179
type: task
ordinal: 347000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
One module call: plan role (create_oidc_provider=true, allowed_ref="*" or scoped to pull_request refs, policy_arns = read-only e.g. ReadOnlyAccess). Per decision-5, no apply role is created -- this repo doesn't automate terraform apply.
<!-- SECTION:DESCRIPTION:END -->
