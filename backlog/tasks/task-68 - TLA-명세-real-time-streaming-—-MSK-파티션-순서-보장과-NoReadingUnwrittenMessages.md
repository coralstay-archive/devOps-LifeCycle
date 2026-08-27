---
id: TASK-68
title: 'TLA+ 명세: real-time-streaming — MSK 파티션 순서 보장과 NoReadingUnwrittenMessages'
status: To Do
assignee: []
created_date: '2026-08-27 06:15'
updated_date: '2026-08-27 06:43'
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
specs/real-time-streaming/spec.tla — 프로듀서가 쓴 메시지 수(produced)와 컨슈머가 읽은 오프셋(consumed)의 관계를 명세해, 컨슈머가 아직 쓰이지 않은 메시지를 읽는 일이 없음을 TLC로 검증한다.

공식문서를 찾아보며 왜 이런 제약이 실제 AWS 서비스의 동작에 대응하는지 이해한 뒤, 아래 페어링된 실습 태스크에서 직접 타이핑하고 TLC로 검증한다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 이 스펙이 모델링하는 시스템 동작(무엇이 상태 변수고 무엇이 액션인지)을 자신의 말로 설명할 수 있다
- [ ] #2 TypeInvariant, NoReadingUnwrittenMessages이(가) 실제로 어떤 실패 시나리오를 막는지 설명할 수 있다
<!-- AC:END -->
