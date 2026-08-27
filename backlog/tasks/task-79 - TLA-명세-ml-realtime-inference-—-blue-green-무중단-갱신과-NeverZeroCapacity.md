---
id: TASK-79
title: 'TLA+ 명세: ml-realtime-inference — blue/green 무중단 갱신과 NeverZeroCapacity'
status: Done
assignee: []
created_date: '2026-08-27 06:16'
updated_date: '2026-08-27 06:17'
labels: []
milestone: m-16
dependencies: []
references:
  - specs/ml-realtime-inference/spec.tla
type: spike
ordinal: 156000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
specs/ml-realtime-inference/spec.tla — green 인스턴스가 뜬 뒤에야 blue를 내리는 순서 제약으로, 서빙 용량이 0이 되는 순간이 없음을 검증했다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [x] #1 TLC 검증: TypeInvariant, NeverZeroCapacity 위반 없음
- [x] #2 CHECK_DEADLOCK FALSE 적용
<!-- AC:END -->
