---
id: TASK-183
title: Define terminology-sourcing & citation convention
status: To Do
assignee: []
created_date: '2026-08-29 12:38'
labels: []
milestone: m-20
dependencies: []
type: task
ordinal: 359000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
Do this before any translation batch starts, so every batch follows the
same pattern instead of each inventing its own.

Decide and write down (e.g. as a short CONVENTIONS note in this milestone,
or at the top of the first batch's PR/commit): for every technical term
translated or introduced (AWS service/feature names, Terraform language
concepts, tool names like tflint/checkov/terraform-docs, etc.), the term
gets wrapped in single quotes at its first meaningful use in a given file,
and a citation is attached noting where its description was sourced from
(official AWS docs URL, the tool's own GitHub README, Terraform registry
docs, etc.) -- not paraphrased from memory. Decide exactly where citations
live (inline parenthetical, a References/Sources section per file, or a
shared sources file) and apply that same choice everywhere.
<!-- SECTION:DESCRIPTION:END -->
