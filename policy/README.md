# policy/

OPA/Rego policies run by Conftest against `terraform show -json` plan output — the custom governance layer that generic scanners (Trivy, Checkov) can't cover, since they check known misconfigurations, not org-specific rules.

## Usage

```
terraform plan -out=tfplan.binary
terraform show -json tfplan.binary > plan.json
conftest test --policy policy plan.json
```

Wired into `terraform-ci.yml` for `live/example-dev` automatically.

## Policies

- `s3_public_access.rego` (**deny** — blocks CI): no S3 bucket may plan with public access allowed. Backstop only — the `s3-bucket` module already sets all four flags to `true`, so this shouldn't ever actually fire unless a scenario declares a raw `aws_s3_bucket_public_access_block` and gets it wrong.
- `required_tags.rego` (**warn** — does not block CI): flags common resource types missing a `Project` tag. A reminder for real deployments, not a scaffold requirement — this repo's modules default `tags = {}`.

## Deny vs warn

Conftest fails the build (non-zero exit) only on `deny` results; `warn` results print but don't block. Use `deny` for things that should never happen (hard security/compliance rules); use `warn` for conventions you want visible but don't want blocking a scaffold-stage repo.

## Adding a policy

Add a `.rego` file with `package main` and a `deny contains msg if { ... }` or `warn contains msg if { ... }` rule (Rego v1 syntax — the `contains`/`if` keywords are required in current OPA/Conftest versions). Test it against a real or synthetic plan JSON before relying on it in CI.
