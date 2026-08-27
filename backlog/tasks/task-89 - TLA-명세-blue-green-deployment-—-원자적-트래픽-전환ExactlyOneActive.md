---
id: TASK-89
title: 'TLA+ 명세: blue-green-deployment — 원자적 트래픽 전환(ExactlyOneActive)'
status: Done
assignee: []
created_date: '2026-08-27 06:18'
updated_date: '2026-08-27 06:18'
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
specs/blue-green-deployment/spec.tla — 활성 타겟 그룹이 언제나 정확히 하나라는 것을, 별도 불변식 없이 단일 변수의 도메인 자체로 구조적으로 보장하는 기법을 명세했다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [x] #1 TLC 검증: TypeInvariant 위반 없음
<!-- AC:END -->
