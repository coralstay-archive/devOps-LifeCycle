---
id: TASK-177.1
title: Install and authenticate AWS CLI
status: In Progress
assignee: []
created_date: '2026-08-29 12:13'
updated_date: '2026-08-29 12:31'
labels: []
dependencies: []
parent_task_id: TASK-177
type: task
ordinal: 340000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
Install awscli (or use SSO) and configure credentials for the target AWS account/region (ap-northeast-2, matching bootstrap/ and live/example-dev defaults).
<!-- SECTION:DESCRIPTION:END -->

## Implementation Notes

<!-- SECTION:NOTES:BEGIN -->
awscli installed via Homebrew (2026-08-29): `brew install awscli` -> aws-cli/2.36.34. `aws --version` confirms.

Still needed: actual credential configuration (`aws configure` or SSO login) against the real target AWS account -- deferred to next session since that requires the user's own account access, not something to do mid-session. Once configured, this task's remaining acceptance is `aws sts get-caller-identity` succeeding (covered by TASK-177.2).
<!-- SECTION:NOTES:END -->
