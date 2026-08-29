---
id: TASK-181
title: Verify plan/apply end-to-end through real CI
status: To Do
assignee: []
created_date: '2026-08-29 12:14'
labels: []
milestone: m-19
dependencies:
  - TASK-180
type: task
ordinal: 352000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
Same verify-by-real-execution discipline used earlier this session for
Infracost and the CI hardening work -- don't trust it until a real PR/merge
proves it. Also the first point where real AWS cost becomes possible
(NAT Gateway x2 in live/example-dev's default vpc config, ~$60-90/mo
combined -- confirmed this session via modules/vpc's enable_nat_gateway
default), so the apply step needs a deliberate, informed approval click,
not a reflexive one.
<!-- SECTION:DESCRIPTION:END -->
