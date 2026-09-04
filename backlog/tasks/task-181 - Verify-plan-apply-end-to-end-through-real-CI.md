---
id: TASK-181
title: Verify plan works end-to-end through real CI
status: To Do
assignee: []
created_date: '2026-08-29 12:14'
updated_date: '2026-09-04 15:10'
labels: []
milestone: m-19
dependencies:
  - TASK-180
type: task
ordinal: 352000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
Don't trust this milestone's plan-role setup until a real PR actually exercises it end to end -- verifying via real execution, not just reading the YAML, has repeatedly caught bugs elsewhere in this repo's CI config that looked correct on paper. Per decision-5, this repo doesn't automate apply, so this is scoped to plan/CI verification only.
<!-- SECTION:DESCRIPTION:END -->
