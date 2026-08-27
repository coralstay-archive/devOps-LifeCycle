---
id: TASK-89
title: 'TLA+ 명세: blue-green-deployment — 원자적 트래픽 전환(ExactlyOneActive)'
status: To Do
assignee: []
created_date: '2026-08-27 06:18'
updated_date: '2026-08-27 06:44'
labels: []
milestone: m-16
dependencies: []
references:
  - specs/blue-green-deployment/spec.tla
type: spike
ordinal: 176000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
specs/blue-green-deployment/spec.tla — 활성 타겟 그룹이 언제나 정확히 하나라는 것을, 별도 불변식 없이 단일 변수의 도메인 자체로 구조적으로 보장하는 기법을 명세하고 TLC로 검증한다.

공식문서를 찾아보며 왜 이런 제약이 실제 AWS 서비스의 동작에 대응하는지 이해한 뒤, 아래 페어링된 실습 태스크에서 직접 타이핑하고 TLC로 검증한다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 이 스펙이 모델링하는 시스템 동작(무엇이 상태 변수고 무엇이 액션인지)을 자신의 말로 설명할 수 있다
- [ ] #2 TypeInvariant이(가) 실제로 어떤 실패 시나리오를 막는지 설명할 수 있다
<!-- AC:END -->
