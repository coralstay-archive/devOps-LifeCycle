---
id: TASK-92
title: >-
  TLA+ 명세: cost-optimized-spot-fleet — Spot 2분 경고와
  NoTerminationWithoutReplacement
status: Done
assignee: []
created_date: '2026-08-27 06:18'
updated_date: '2026-08-27 06:18'
labels: []
milestone: m-16
dependencies: []
references:
  - specs/cost-optimized-spot-fleet/spec.tla
type: spike
ordinal: 182000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
specs/cost-optimized-spot-fleet/spec.tla — Spot 인터럽션 경고 이후 대체 노드 요청 없이 바로 종료되는 경로가 없다는 것을 명세했다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [x] #1 TLC 검증: TypeInvariant, NoTerminationWithoutReplacement 위반 없음
- [x] #2 버그 시나리오(TerminateWithoutReplacement)를 주석으로 남겨 대조
<!-- AC:END -->
