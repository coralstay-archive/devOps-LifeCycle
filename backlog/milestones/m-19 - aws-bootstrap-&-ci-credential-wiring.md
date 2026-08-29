---
id: m-19
title: "AWS Bootstrap & CI Credential Wiring"
---

## Description

Connects this repo to a real AWS account so the CI secrets `AWS_PLAN_ROLE_ARN`
and `AWS_APPLY_ROLE_ARN` (see the root README's "One-time setup" section)
actually exist and work. As of this milestone's creation, `modules/iam-github-oidc`
-- the module that's supposed to create those two IAM roles -- is written but
never instantiated anywhere in the repo, so there is no real ARN to register as
either secret, and every CI step that needs AWS credentials fails at that step
by design.

This milestone is the concrete build-out, in order: get local AWS access,
apply `bootstrap/` for real (creates the Terraform state bucket), create the
plan/apply IAM roles via `modules/iam-github-oidc`, register both secrets on
GitHub, then verify the whole chain end-to-end through a real PR (plan) and a
real, human-approved apply.

Like `m-17`/`m-18`, this is real engineering work meant to actually get done --
not the conceptual learning backlog (`m-0`-`m-16`), where tasks are
intentionally left for a human to work through by hand. Unlike `m-17`/`m-18`
(both flat lists of independent bug-type tasks), this milestone's stories have
a genuine must-happen-in-this-order dependency chain, so it's modeled as a
proper Epic (this milestone) -> Story -> Task hierarchy instead.
