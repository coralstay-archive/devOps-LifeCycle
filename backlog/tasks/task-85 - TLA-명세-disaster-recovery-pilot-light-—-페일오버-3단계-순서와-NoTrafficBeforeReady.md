---
id: TASK-85
title: 'TLA+ 명세: disaster-recovery-pilot-light — 페일오버 3단계 순서와 NoTrafficBeforeReady'
status: To Do
assignee: []
created_date: '2026-08-27 06:17'
updated_date: '2026-08-27 06:44'
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
specs/disaster-recovery-pilot-light/spec.tla — 복제본 승격 -> 용량 확장 -> 트래픽 전환의 순서를 어기면 안 된다는 DR 페일오버의 안전 속성을 명세하고 TLC로 검증한다.

공식문서를 찾아보며 왜 이런 제약이 실제 AWS 서비스의 동작에 대응하는지 이해한 뒤, 아래 페어링된 실습 태스크에서 직접 타이핑하고 TLC로 검증한다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 이 스펙이 모델링하는 시스템 동작(무엇이 상태 변수고 무엇이 액션인지)을 자신의 말로 설명할 수 있다
- [ ] #2 TypeInvariant, NoTrafficBeforeReady이(가) 실제로 어떤 실패 시나리오를 막는지 설명할 수 있다
<!-- AC:END -->
