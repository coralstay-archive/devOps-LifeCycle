---
id: TASK-182
title: Harden AWS_APPLY_ROLE_ARN trust policy with environment-scoped OIDC condition
status: To Do
assignee: []
created_date: '2026-08-29 12:15'
updated_date: '2026-08-29 12:32'
labels: []
milestone: m-19
dependencies:
  - TASK-181
type: task
ordinal: 356000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
Follow-on from this repo's CI-governance hardening work (branch ruleset, environment protection rules, SHA-pinned GitHub Actions, action allow-list) -- deferred at the time because no AWS account or OIDC role existed yet to apply it against. Once the apply role from TASK-179 is real, add the environment-scoped sub claim (repo:amosQP/aws-launcher:environment:production) alongside the existing ref condition in modules/iam-github-oidc's trust policy, so even a leaked GITHUB_TOKEN or a workflow run outside the intended path can't assume the apply role -- ref-restriction alone isn't enough once the role can do real damage.
<!-- SECTION:DESCRIPTION:END -->
