---
id: TASK-83
title: 'TLA+ 명세: zero-trust-edge — WAF 우회 방지와 NoBypassingWAF'
status: Done
assignee: []
created_date: '2026-08-27 06:17'
updated_date: '2026-08-27 06:17'
labels: []
milestone: m-16
dependencies: []
references:
  - specs/zero-trust-edge/spec.tla
type: spike
ordinal: 164000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
specs/zero-trust-edge/spec.tla — 오리진에 도달한 모든 요청은 반드시 WAF 검사를 통과했어야 한다는 제로 트러스트 엣지의 핵심 전제를 명세했다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [x] #1 TLC 검증: TypeInvariant, NoBypassingWAF 위반 없음
<!-- AC:END -->
