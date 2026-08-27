---
id: TASK-74
title: 'TLA+ 명세: session-store — TTL 만료와 ExpiredIsNeverActive'
status: Done
assignee: []
created_date: '2026-08-27 06:16'
updated_date: '2026-08-27 06:16'
labels: []
milestone: m-16
dependencies: []
references:
  - specs/session-store/spec.tla
type: spike
ordinal: 146000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
specs/session-store/spec.tla — Redis 세션의 TTL 카운트다운과 만료 후 재활성화 불가 속성을 명세했다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [x] #1 TLC 검증: TypeInvariant, ExpiredIsNeverActive 위반 없음
- [x] #2 CHECK_DEADLOCK FALSE 적용
<!-- AC:END -->
