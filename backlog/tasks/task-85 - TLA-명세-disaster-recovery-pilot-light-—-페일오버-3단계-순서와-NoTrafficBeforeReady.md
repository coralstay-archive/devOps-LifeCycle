---
id: TASK-85
title: 'TLA+ 명세: disaster-recovery-pilot-light — 페일오버 3단계 순서와 NoTrafficBeforeReady'
status: Done
assignee: []
created_date: '2026-08-27 06:17'
updated_date: '2026-08-27 06:17'
labels: []
milestone: m-16
dependencies: []
references:
  - specs/disaster-recovery-pilot-light/spec.tla
type: spike
ordinal: 168000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
specs/disaster-recovery-pilot-light/spec.tla — 복제본 승격 -> 용량 확장 -> 트래픽 전환의 순서를 어기면 안 된다는 DR 페일오버의 안전 속성을 명세했다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [x] #1 TLC 검증: TypeInvariant, NoTrafficBeforeReady 위반 없음
- [x] #2 CHECK_DEADLOCK FALSE 적용
<!-- AC:END -->
