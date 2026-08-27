---
id: TASK-81
title: 'TLA+ 명세: multi-account-landing-zone — 계정 생성과 가드레일 원자성'
status: Done
assignee: []
created_date: '2026-08-27 06:17'
updated_date: '2026-08-27 06:17'
labels: []
milestone: m-16
dependencies: []
references:
  - specs/multi-account-landing-zone/spec.tla
type: spike
ordinal: 160000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
specs/multi-account-landing-zone/spec.tla — 계정이 조직에 합류하는 순간 가드레일(SCP)도 함께 적용된다는 원자적 보장을 명세했다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [x] #1 TLC 검증: TypeInvariant, NoAccountWithoutGuardrails 위반 없음
- [x] #2 CHECK_DEADLOCK FALSE 적용
<!-- AC:END -->
