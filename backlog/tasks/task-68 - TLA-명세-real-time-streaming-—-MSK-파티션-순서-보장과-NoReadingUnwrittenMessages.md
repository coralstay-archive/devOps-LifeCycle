---
id: TASK-68
title: 'TLA+ 명세: real-time-streaming — MSK 파티션 순서 보장과 NoReadingUnwrittenMessages'
status: Done
assignee: []
created_date: '2026-08-27 06:15'
updated_date: '2026-08-27 06:15'
labels: []
milestone: m-16
dependencies: []
references:
  - specs/real-time-streaming/spec.tla
type: spike
ordinal: 134000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
specs/real-time-streaming/spec.tla — 프로듀서가 쓴 메시지 수(produced)와 컨슈머가 읽은 오프셋(consumed)의 관계를 명세해, 컨슈머가 아직 쓰이지 않은 메시지를 읽는 일이 없음을 검증했다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [x] #1 TLC 검증: TypeInvariant, NoReadingUnwrittenMessages 위반 없음
- [x] #2 CHECK_DEADLOCK FALSE로 자연스러운 종료 상태 허용
<!-- AC:END -->
