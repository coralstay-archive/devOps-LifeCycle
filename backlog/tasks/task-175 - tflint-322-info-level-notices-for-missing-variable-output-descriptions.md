---
id: TASK-175
title: 'tflint: 322 info-level notices for missing variable/output descriptions'
status: To Do
assignee: []
created_date: '2026-08-28 04:33'
labels: []
milestone: m-17
dependencies: []
type: bug
ordinal: 337000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
186 undocumented variables + 136 undocumented outputs across all 36 modules (terraform_documented_variables/terraform_documented_outputs rules) — confirmed via 'tflint --recursive --config=$(pwd)/.tflint.hcl'. Note: tflint does NOT auto-discover .tflint.hcl in parent directories — --recursive from repo root without an explicit --config path silently reports 0 issues once it descends into subdirectories, which is how this went unnoticed; always pass --config explicitly. Mechanical fix: add a one-line description to every flagged variable/output.
<!-- SECTION:DESCRIPTION:END -->
