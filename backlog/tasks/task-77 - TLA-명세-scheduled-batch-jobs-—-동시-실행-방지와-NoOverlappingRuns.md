---
id: TASK-77
title: 'TLA+ 명세: scheduled-batch-jobs — 동시 실행 방지와 NoOverlappingRuns'
status: Done
assignee: []
created_date: '2026-08-27 06:16'
updated_date: '2026-08-27 06:16'
labels: []
milestone: m-16
dependencies: []
references:
  - specs/scheduled-batch-jobs/spec.tla
type: spike
ordinal: 152000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
specs/scheduled-batch-jobs/spec.tla — EventBridge 스케줄이 이전 실행 중 트리거되면 건너뛰는 동시 실행 방지 로직을 명세했다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [x] #1 TLC 검증: TypeInvariant, NoOverlappingRuns 위반 없음
- [x] #2 CHECK_DEADLOCK FALSE 적용
<!-- AC:END -->
