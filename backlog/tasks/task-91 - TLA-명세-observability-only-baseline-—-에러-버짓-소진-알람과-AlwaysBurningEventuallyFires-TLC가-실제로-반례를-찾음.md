---
id: TASK-91
title: >-
  TLA+ 명세: observability-only-baseline — 에러 버짓 소진 알람과
  AlwaysBurningEventuallyFires (TLC가 실제로 반례를 찾음)
status: Done
assignee: []
created_date: '2026-08-27 06:18'
updated_date: '2026-08-27 06:18'
labels: []
milestone: m-16
dependencies: []
references:
  - specs/observability-only-baseline/spec.tla
type: spike
ordinal: 180000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
specs/observability-only-baseline/spec.tla — 처음엔 'burning이 한 번이라도 시작되면 결국 알람이 울린다'를 WF_vars(AlarmFires)만으로 명세했는데, TLC가 'burning이 알람 평가 전에 순간적으로 꺼지는' flapping 반례를 실제로 찾아냈다. 전제를 '[]burning => <>Firing'(계속 지속되는 burning)으로 고쳐 재검증했다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [x] #1 1차 시도(WF만, burning ~> Firing)는 TLC가 반례 발견 — 실패 로그 보존 가치 있음
- [x] #2 수정 후 TLC 검증: TypeInvariant 위반 없음, PROPERTY AlwaysBurningEventuallyFires 통과
<!-- AC:END -->
