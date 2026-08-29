---
id: TASK-179
title: Create the GitHub OIDC plan/apply IAM roles
status: To Do
assignee: []
created_date: '2026-08-29 12:13'
updated_date: '2026-08-29 12:32'
labels: []
milestone: m-19
dependencies:
  - TASK-178
type: task
ordinal: 345000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
modules/iam-github-oidc exists but is never instantiated anywhere in this repo (confirmed via grep across all .tf files) -- there is no real ARN to register yet. Needs a small root module (e.g. bootstrap/iam.tf, or a new bootstrap/oidc/ stack) that calls the module twice per its own README's "Usage note": a narrow plan role for PR checks, a broader apply role restricted to allowed_ref = "refs/heads/main". Don't reuse one role for both.
<!-- SECTION:DESCRIPTION:END -->
