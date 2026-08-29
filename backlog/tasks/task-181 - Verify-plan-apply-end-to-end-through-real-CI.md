---
id: TASK-181
title: Verify plan/apply end-to-end through real CI
status: To Do
assignee: []
created_date: '2026-08-29 12:14'
updated_date: '2026-08-29 12:32'
labels: []
milestone: m-19
dependencies:
  - TASK-180
type: task
ordinal: 352000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
Don't trust this milestone's setup until a real PR (plan) and a real merge (apply) actually exercise it end to end -- verifying via real execution, not just reading the YAML, has repeatedly caught bugs elsewhere in this repo's CI config that looked correct on paper. This story is also the first point where real AWS cost becomes possible: live/example-dev's default vpc config creates 2 NAT Gateways (modules/vpc's enable_nat_gateway defaults to true, one per AZ), roughly $60-90/month combined. The apply approval click needs to be deliberate and informed, not reflexive.
<!-- SECTION:DESCRIPTION:END -->
