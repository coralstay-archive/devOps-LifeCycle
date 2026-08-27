---
id: decision-4
title: 모듈 스코프 동작 명세에 입력-연산-출력 TLA+ 적용
date: '2026-08-27 14:23'
status: accepted
---
## Context

[[decision-2]] rejected TLA+ at module scope on a specific ground: a Terraform module is a declarative resource graph, not a concurrent algorithm, so a model checker has no meaningful state space to explore. That reasoning is still correct for the thing it addressed — module-level concurrency modeling. But it left a different question open: can TLA+ still describe what a module *does*, independent of concurrency? Every module already has a natural three-part shape — `variables.tf` (input), the AWS API calls `main.tf` triggers (an operation), `outputs.tf` plus what it must always guarantee (output + postcondition). That shape is exactly what TLA+ operators (not state machines) are good at specifying precisely.

## Decision

We wrote one `specs/modules/<module>/spec.tla` + `spec.cfg` per module (all 36), each specifying the module as input → operation → output rather than as a state machine: `Input` (built from `CONSTANTS` mirroring `variables.tf`), `Precondition` (the input domain the module assumes), `Provision` (the AWS API sequence `main.tf` actually performs, as a pure operator — `LET`-bound steps, not `Init`/`Next`), and `Postcondition` (what `outputs.tf` must always satisfy). Each spec has no real `VARIABLES` — TLC checks the contract via a single-state dummy `Spec`, confirming `Precondition(Input) => Postcondition(Input, Provision(Input))` for one concrete example, not proving it for every possible input. That's a real limitation, not glossed over: static type constraints for *all* inputs still live in `variables.tf` and each module's own `precondition`/`postcondition` blocks (decision-2's territory, unchanged).

Two categories emerged:
- **Modules with a real, callable-out algorithm** (s3-bucket, vpc, alb, iam-github-oidc, dynamodb, etc.): `Provision` lists the actual AWS API calls in order, with real branches (e.g. alb's listener depends on whether `certificate_arn` is set; ec2's AMI lookup when `ami_id` is null).
- **Managed/black-box services** (eks, rds-postgres, redshift, elasticache-redis, msk-kafka, sagemaker): AWS manages the internal behavior (replication, failover, node placement), so `Provision` uses a deliberately abstract verb ("provision a managed resource with this config") instead of pretending to know AWS's internal algorithm. The postcondition still captures whatever the module *does* actually enforce (e.g. eks's `min <= desired <= max`, msk-kafka's broker-count-is-a-multiple-of-subnet-count).

Writing these contracts surfaced 3 real gaps in the actual modules, fixed directly rather than just noted:
- `dms`: `target_engine_name` defaults to `"kafka"` and `target_kafka_broker` defaults to `null` — nothing stopped that combination, which plans fine and fails at DMS endpoint-creation time with a much less specific error. Added a `precondition` requiring the broker when the engine is kafka.
- `redshift`: `manage_master_password = true` already makes AWS generate and store the master password, but the module never exposed `master_password_secret_arn` — there was no way to actually retrieve it. Added the output (mirroring `rds-postgres`).
- `amazon-mq`: no validation that `password` meets Amazon MQ's own 12-250 character API requirement. Added the `precondition`.

Terminology note: earlier drafts of these specs repeatedly labeled the approach "CLRS-style" (after *Introduction to Algorithms*) in every file's header — purely as a mental-model anchor, not because the module specs prove anything CLRS-style (they check one example, not all inputs). That framing added noise without adding precision, so it was removed everywhere in favor of describing the input/operation/output shape directly. The word used throughout for "what a module does" is **동작** (behavior) — matching the term already used for scenario-level runtime behavior in `specs/README.md` and decision-3, not **계약** (contract), which reads more formal/legalistic than what these specs actually establish.

## Consequences

- Three scopes now, three tools, no overlap: module-level static input constraints stay in Terraform `precondition`/`postcondition` (checked on every `plan`/`apply`); module-level input→operation→output behavior lives in `specs/modules/*` (checked on demand via TLC, documentation/learning artifact, not a pipeline gate); scenario-level runtime/ordering/concurrency behavior lives in `specs/<scenario>/*` (decision-3, also on-demand).
- These module specs are not proofs. A learner should not read "TLC found no error" as "this module is correct for all inputs" — it means the one example in `spec.cfg` satisfies the postcondition. Widening coverage (different input combinations) is exactly what the paired learning tasks in the backlog are for.
- Real module fixes (dms, redshift, amazon-mq) came from *writing* these specs carefully enough to notice the gap, not from TLC catching a state-space violation — a different, more manual kind of value than the counter-examples decision-3 found for scenarios, but real all the same.
