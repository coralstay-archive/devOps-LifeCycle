---
id: TASK-182
title: Harden AWS_APPLY_ROLE_ARN trust policy with environment-scoped OIDC condition
status: To Do
assignee: []
created_date: '2026-08-29 12:15'
labels: []
milestone: m-19
dependencies:
  - TASK-181
type: task
ordinal: 356000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
Deferred item from the CI-governance hardening session (item 6 of 6) --
blocked at the time because no AWS account/OIDC role existed yet. Once the
apply role is real, add the environment-scoped sub claim
(repo:amosQP/aws-launcher:environment:production) alongside the existing
ref condition in modules/iam-github-oidc's trust policy, so even a leaked
GITHUB_TOKEN or a workflow run outside the intended path can't assume the
apply role -- ref-restriction alone isn't enough once the role can do real
damage.
<!-- SECTION:DESCRIPTION:END -->
