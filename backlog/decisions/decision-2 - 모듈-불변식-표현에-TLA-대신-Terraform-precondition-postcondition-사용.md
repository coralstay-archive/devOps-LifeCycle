---
id: decision-2
title: 모듈 불변식 표현에 TLA+ 대신 Terraform precondition/postcondition 사용
date: '2026-08-27 05:05'
status: accepted
---
## Context

TLA+ is a formal specification language used to model and verify concurrent/distributed algorithms (AWS itself uses it internally for services like S3 and DynamoDB). The question came up whether each Terraform module in this repo should get a TLA+ spec, in service of the project's broader goal of learning each module's defaults, usage, and invariants rigorously.

## Decision

We did not adopt TLA+. Terraform modules are declarative resource graphs, not concurrent algorithms — there's no meaningful state space for a model checker to explore, and no precedent found for applying TLA+ to Infrastructure-as-Code configurations. Instead, we use Terraform's own native `precondition`/`postcondition` blocks (in resource/data/output `lifecycle` blocks) to express the same underlying goal TLA+ would serve: explicit, checked invariants. All 36 modules now have at least one, usually enforcing a real AWS API constraint (e.g. ALB requires >= 2 AZs, KMS deletion window must be 7-30 days, MSK broker count must be a multiple of subnet count) rather than an arbitrary style rule.

## Consequences

- Invariants are checked on every real `plan`/`apply`, not just in a separate test suite — they're load-bearing, not documentation.
- This stays entirely within the Terraform ecosystem the project is trying to learn, rather than introducing an unrelated formal-methods tool with a steep learning curve and no established IaC use case.
- Coverage is per-module and additive — as we go through the learning backlog, add more `precondition`/`postcondition` (or `check` blocks for cross-cutting invariants) as gaps are found, rather than trying to formally prove correctness up front.

