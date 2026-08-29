---
id: m-19
title: "AWS Bootstrap & CI Credential Wiring"
---

## Description

Connects this repo to a real AWS account so AWS_PLAN_ROLE_ARN/AWS_APPLY_ROLE_ARN
actually work in CI. Right now modules/iam-github-oidc exists but is never
instantiated anywhere in the repo -- there's no real ARN to register as either
secret. This milestone is the concrete build-out: local AWS access, bootstrap/
applied for real, the plan/apply IAM roles actually created via
modules/iam-github-oidc, secrets registered, and the whole chain verified
end-to-end through a real PR and a real (approved) apply.

Engineering work meant to actually get done (like m-17/m-18), not the
conceptual learning backlog (m-0..m-16) -- but broken into a real
epic/story/task hierarchy per user request, not a flat bug list.
