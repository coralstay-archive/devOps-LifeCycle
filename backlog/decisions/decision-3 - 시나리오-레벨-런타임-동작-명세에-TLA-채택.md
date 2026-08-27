---
id: decision-3
title: 시나리오 레벨 런타임 동작 명세에 TLA+ 채택
date: '2026-08-27 06:20'
status: accepted
---
## Context

[[decision-2]] rejected TLA+ at the **module** scope: a single Terraform module is a declarative resource graph with no meaningful concurrent state space, so a model checker has nothing useful to explore there. But `scenarios/` is a different scope — it composes multiple modules into a system that actually has runtime behavior over time: ALB health checks flip states, Lambda dispatches warm vs. cold, SNS fans out to N independent subscribers at different speeds, DMS runs two ordered phases, multi-region replication lags asynchronously. None of that is expressible in HCL `precondition`/`postcondition` (those only see one `plan`/`apply` snapshot); it needs a model of states and transitions over time, which is exactly what TLA+ is for.

## Decision

We adopted TLA+ for all 30 `scenarios/`, scoped strictly to runtime system behavior — never as a replacement for module-level `precondition`/`postcondition` (decision-2 still stands for that scope). Each scenario got `specs/<scenario>/spec.tla` + `spec.cfg` under a new top-level `specs/` directory, model-checked with TLC (`.tla-tools/tla2tools.jar`, downloaded — not committed as a repo binary). Each spec is small and bounded on purpose (a handful of state variables, `CHECK_DEADLOCK FALSE` where a terminal state is legitimate) — the goal is a fast, readable, hands-on model of *one* interesting behavioral property per scenario, not exhaustive formal verification of the whole system.

TLC earned its keep twice during this work, not just as a teaching exercise:
- `serverless-api`: the first `DispatchCold` action let `warmInstances` grow past `MaxConcurrency` — TLC found the `TypeInvariant` violation immediately; fixed by adding a `warmInstances < MaxConcurrency` guard.
- `observability-only-baseline`: a naive liveness claim (`burning ~> Firing` under weak fairness) had a flapping counter-example — `burning` could toggle off right before the alarm evaluated, so TLC found a valid trace where the alarm never fires. The fix wasn't stronger fairness (strong fairness has the same gap for a one-shot toggle); it was correcting the property itself to require *sustained* burning. The first rewrite, `[]burning => <>Firing`, turned out to be a second, subtler bug: `burning` starts `FALSE` in `Init`, so `[]burning` (true at *every* point of the behavior, including t=0) is false for every reachable behavior — the whole implication was vacuously true and verified nothing. The actual fix is `(<>[]burning) => (<>Firing)` ("if burning eventually becomes permanently true, the alarm eventually fires"), which also matches how CloudWatch's evaluation-period alarms actually behave, and which TLC confirmed is non-vacuous: it holds under `WF_vars(AlarmFires)` and is violated without it.

Every `.tla` file carries Korean-language learning comments (block comment at top explaining what's modeled and why, inline comments per action) — same convention as the Terraform learning comments added across all modules/scenarios. The learning project itself is tracked via `backlog.md` under a new milestone, **Formal Specifications (TLA+)** (m-16): one story-task per scenario (what was modeled, which invariant/property, TLC result) plus one child task per scenario aimed at deepening the concept hands-on against official docs (e.g., fairness operators, `EXCEPT` function updates, model values, leads-to `~>`) — mirroring the Epic → Story → Task structure already used for the module/scenario learning backlog.

## Consequences

- Two scopes, two tools, no overlap: module-level static constraints stay in Terraform `precondition`/`postcondition` (checked on every `plan`/`apply`); scenario-level runtime/ordering/concurrency behavior lives in TLA+ (checked on demand via TLC, not part of CI). This decision does not add TLA+ to any pipeline — it's a learning/design artifact, not a deploy-time gate.
- `.tla-tools/tla2tools.jar` is a downloaded tool, not vendored — anyone picking this up needs to fetch it themselves (documented download command lives alongside the specs), consistent with not committing large binaries to the repo.
- Coverage is intentionally shallow-but-real per scenario: one or two properties that capture the scenario's actual interesting risk (e.g. idempotency for SQS, all-or-nothing commit for Redshift COPY, WAF bypass prevention), not a complete model of every module wired into that scenario. Deepening any given spec is exactly what the paired learning child-task in the backlog is for.
