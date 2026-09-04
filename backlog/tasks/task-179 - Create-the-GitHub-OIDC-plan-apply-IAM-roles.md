---
id: TASK-179
title: Create the GitHub OIDC plan IAM role
status: To Do
assignee: []
created_date: '2026-08-29 12:13'
updated_date: '2026-09-04 15:09'
labels: []
milestone: m-19
dependencies:
  - TASK-178
type: task
ordinal: 345000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
modules/iam-github-oidc exists but is never instantiated anywhere in this repo (confirmed via grep across all .tf files) -- there is no real ARN to register yet. Needs a small root module (e.g. bootstrap/iam.tf, or a new bootstrap/oidc/ stack) that calls the module once for a read-only plan role used by terraform-ci.yml. Per decision-5, this repo no longer automates apply -- only the plan role is needed.
<!-- SECTION:DESCRIPTION:END -->
