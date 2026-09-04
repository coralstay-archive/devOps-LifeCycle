---
id: m-19
title: "AWS Bootstrap & CI Credential Wiring"
---

## Description

Connects this repo to a real AWS account so the CI secret `AWS_PLAN_ROLE_ARN`
(see the root README's "One-time setup" section) actually exists and works.
As of this milestone's creation, `modules/iam-github-oidc` -- the module
that's supposed to create that IAM role -- is written but never instantiated
anywhere in the repo, so there is no real ARN to register as the secret, and
every CI step that needs AWS credentials fails at that step by design.

Per `decision-5`, this repo doesn't automate `terraform apply` -- real
deploys are run manually from a human's machine, and there is no
`AWS_APPLY_ROLE_ARN` or apply/drift-detect automation. This milestone is
scoped down accordingly: get local AWS access, apply `bootstrap/` for real
(creates the Terraform state bucket), create the plan-only IAM role via
`modules/iam-github-oidc`, register that secret on GitHub, then verify the
chain end-to-end through a real PR (plan only).

Like `m-17`/`m-18`, this is real engineering work meant to actually get done --
not the conceptual learning backlog (`m-0`-`m-16`), where tasks are
intentionally left for a human to work through by hand. Unlike `m-17`/`m-18`
(both flat lists of independent bug-type tasks), this milestone's stories have
a genuine must-happen-in-this-order dependency chain, so it's modeled as a
proper Epic (this milestone) -> Story -> Task hierarchy instead.
