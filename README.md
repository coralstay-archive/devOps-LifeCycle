# aws-launcher

A reusable "launchpad" for starting new AWS projects: pick a scenario that matches your situation, copy it, deploy it. Built around three layers, IaC quality gates in CI, and Google-SRE-style operating principles baked in from the start (not bolted on later).

## Layers

```
modules/    atomic, reusable Terraform building blocks (vpc, eks, redis, kafka, ...)
scenarios/  recipes that combine modules for a specific situation — no state, not deployable as-is
live/       actual deployments — copies of a scenario, managed independently from then on
```

**Why copy instead of reference by `source =`:** once `live/<project>` is copied from a `scenarios/<x>`, it's yours — you can adapt it freely and it won't shift under you if the scenario template later improves. The tradeoff is that scenario improvements don't automatically propagate to already-deployed projects; you'd need to manually port them. This is intentional: production infrastructure shouldn't move just because a template changed.

## Starting a new project

1. Pick the closest match under `scenarios/` (see backlog table below).
2. Copy it: `cp -r scenarios/<slug> live/<your-project-name>`
3. Fill in `backend.tf` (get bucket/table names from `bootstrap/`, see below), `providers.tf` region, and `variables.tf` / a new `terraform.tfvars`.
4. Fill in `SLO.md` with real availability/latency targets for this project.
5. `terraform init && terraform plan` locally, then open a PR — `terraform-ci.yml` runs fmt/validate/tflint/trivy and posts a plan + cost diff as PR comments.
6. Merge to `main` → `terraform-apply.yml` applies (gated behind manual approval on the `production` GitHub Environment).

## One-time setup

- **State backend**: run `bootstrap/` once per AWS account/region to create the S3 state bucket + DynamoDB lock table (see `bootstrap/README.md`).
- **CI credentials**: use `modules/iam-github-oidc` to create two roles — a narrow `plan` role (`AWS_PLAN_ROLE_ARN` secret) and a broader `apply` role restricted to `refs/heads/main` (`AWS_APPLY_ROLE_ARN` secret). No long-lived AWS keys in GitHub.
- **Infracost**: add an `INFRACOST_API_KEY` repo secret (free key from infracost.io).
- **Local dev**: `pip install pre-commit && pre-commit install` to run the same fmt/validate/tflint/terraform-docs/trivy/checkov/gitleaks checks before you commit. Also install `terraform-docs`, `checkov`, `conftest`, and `k6` locally (`brew install terraform-docs checkov conftest k6`) if you want to run them outside pre-commit/CI.

## Testing modules

`modules/vpc`, `modules/s3-bucket`, and `modules/iam-github-oidc` have `tests/*.tftest.hcl` using Terraform's native test framework with `mock_provider` — no AWS credentials needed, runs in seconds (`cd modules/<name> && terraform init -backend=false && terraform test`). Extend this pattern to other modules as they get picked up from the backlog; `terraform-ci.yml` automatically runs `terraform test` for any module with a `tests/` directory.

## Custom policy checks

`policy/` holds Conftest (OPA/Rego) policies run against `terraform plan` JSON — the layer generic scanners can't cover, since Trivy/Checkov catch known misconfigurations while Conftest enforces this repo's own rules (e.g. no public S3 buckets, regardless of how a future scenario might declare one). See `policy/README.md` for the deny-vs-warn convention.

## Tooling

| Purpose | Tool | Blocking in CI? |
|---|---|---|
| IaC | Terraform | — |
| Lint | TFLint (+ AWS ruleset) | yes |
| Docs | terraform-docs (auto-generates each module's Inputs/Outputs tables — see the `<!-- BEGIN_TF_DOCS -->` block in every `modules/*/README.md`) | yes (fails if docs are stale) |
| Security/compliance scan | Trivy (config scan) | no — see below |
| Security/compliance scan (2nd opinion) | Checkov | no — see below |
| Custom policy-as-code | Conftest (OPA/Rego), `policy/` dir | deny rules yes, warn rules no |
| Module unit tests | `terraform test` (native, `mock_provider`, no AWS creds needed) | yes, for modules with a `tests/` dir |
| Cost estimation | Infracost | no (informational PR comment) |
| Secret scanning | gitleaks | yes |
| Drift detection | scheduled `terraform plan -detailed-exitcode` (`.github/workflows/drift-detect.yml`) — driftctl is unmaintained, this is the current practical alternative | opens a tracking issue, doesn't block PRs |

**Why Trivy/Checkov are non-blocking here**: this repo's modules are intentionally minimal (see each module's "Not yet included" section) — e.g. Redshift isn't KMS-encrypted, SNS/SQS aren't encrypted by default. Both scanners correctly flag these as real findings; they're accepted trade-offs at the scaffold stage, not bugs. They still run and report on every PR for visibility (`continue-on-error` in `terraform-ci.yml`). Flip a specific project to blocking once a scenario graduates from scaffold to a real production workload.

A mature IaC stack typically runs two security scanners in parallel since their detection coverage differs — that's Trivy + Checkov here, not redundancy.

## SRE principles applied to every scenario

1. **SLI/SLO first** — every `live/<project>` carries an `SLO.md` (availability, latency, error budget policy).
2. **Observability from day one** — `modules/observability` (CloudWatch baseline, Prometheus/Grafana for EKS scenarios) is part of the recipe, not an afterthought.
3. **Spike-ready autoscaling** — Karpenter on EKS, ElastiCache read replicas, MSK partition scaling, ALB/API Gateway throttling.
4. **Load testing before trust** — `tools/loadtest/` k6 templates rehearse sudden spikes (Google/Spotify-style) against the SLO thresholds.
5. **Multi-AZ by default**, multi-region only where a scenario specifically needs it.

## Modules status

All 34 modules are implemented (minimal, default-heavy — the point is a working baseline, not every feature) and pass `terraform validate`:

| Tier | Modules |
|---|---|
| Foundation | `vpc`, `s3-bucket`, `iam-github-oidc` |
| Compute/network | `eks`, `ecs-service`, `elasticache-redis`, `msk-kafka`, `rds-postgres`, `observability` |
| 1 — general-purpose primitives | `alb`, `acm`, `route53`, `kms`, `secrets-manager`, `ecr` |
| 2 — serverless | `lambda`, `dynamodb`, `api-gateway`, `sns-sqs`, `eventbridge`, `cloudfront` |
| 3 — data/analytics | `glue`, `athena`, `redshift`, `dms`, `step-functions` |
| 4 — ML/AI & governance | `sagemaker`, `bedrock-opensearch`, `organizations-landing-zone`, `waf-shield`, `aws-backup`, `codedeploy`, `vpc-endpoints` |
| Messaging (niche) | `amazon-mq` — only for AMQP/MQTT/STOMP protocol compatibility; `sns-sqs` is the default choice for anything new |

Each module's own README documents its "Not yet included" gaps — check there before assuming a feature exists.

## Scenarios (30)

All 30 are composed (module calls wired together, `terraform validate` passing) — not just README stubs anymore. What's still open per scenario is documented as "참고자료: TBD" in each one's README: the deeper implementation detail that will come from official docs / book references brought in as each is actually put into production, plus any "알려진 제약" (known gap) noted where a real-world detail didn't fit the minimal-default philosophy (e.g. `blue-green-deployment`'s ECS deployment controller, `high-traffic-spike`'s missing EKS node security group wiring).

| # | Scenario | Category |
|---|---|---|
| 1 | `standard-web` | 웹/API |
| 2 | `high-traffic-spike` | 웹/API |
| 3 | `serverless-api` | 웹/API |
| 4 | `static-site-cdn` | 웹/API |
| 5 | `multi-tenant-saas` | 웹/API |
| 6 | `real-time-streaming` | 데이터/스트리밍 |
| 7 | `data-lake` | 데이터/스트리밍 |
| 8 | `data-warehouse` | 데이터/스트리밍 |
| 9 | `cdc-pipeline` | 데이터/스트리밍 |
| 10 | `etl-batch` | 데이터/스트리밍 |
| 11 | `read-heavy-caching` | 캐싱/성능 |
| 12 | `session-store` | 캐싱/성능 |
| 13 | `event-driven-microservices` | 이벤트/메시징 |
| 14 | `pub-sub-fanout` | 이벤트/메시징 |
| 15 | `scheduled-batch-jobs` | 이벤트/메시징 |
| 16 | `ml-training-pipeline` | ML/AI |
| 17 | `ml-realtime-inference` | ML/AI |
| 18 | `llm-rag-service` | ML/AI |
| 19 | `multi-account-landing-zone` | 네트워크/보안 |
| 20 | `private-vpc-only` | 네트워크/보안 |
| 21 | `zero-trust-edge` | 네트워크/보안 |
| 22 | `multi-region-active-active` | 가용성/재해복구 |
| 23 | `disaster-recovery-pilot-light` | 가용성/재해복구 |
| 24 | `backup-restore-baseline` | 가용성/재해복구 |
| 25 | `eks-multi-tenant-cluster` | 컨테이너/배포전략 |
| 26 | `ecs-fargate-microservices` | 컨테이너/배포전략 |
| 27 | `blue-green-deployment` | 컨테이너/배포전략 |
| 28 | `canary-deployment` | 컨테이너/배포전략 |
| 29 | `observability-only-baseline` | 운영/비용 |
| 30 | `cost-optimized-spot-fleet` | 운영/비용 |

## Reference example

`live/example-dev` is a minimal, actually-`plan`-able stack (vpc + s3-bucket only) proving the pipeline end to end. `scenarios/standard-web` now has the fuller composition (ALB+ECS+RDS+observability); `example-dev` stays as the simplest possible smoke test of the CI/CD plumbing itself.
