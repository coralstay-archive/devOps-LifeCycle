---
id: TASK-81
title: 'TLA+ 명세: multi-account-landing-zone — 계정 생성과 가드레일 원자성'
status: To Do
assignee: []
created_date: '2026-08-27 06:17'
updated_date: '2026-08-27 06:43'
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
specs/multi-account-landing-zone/spec.tla — 계정이 조직에 합류하는 순간 가드레일(SCP)도 함께 적용된다는 원자적 보장을 명세하고 TLC로 검증한다.

공식문서를 찾아보며 왜 이런 제약이 실제 AWS 서비스의 동작에 대응하는지 이해한 뒤, 아래 페어링된 실습 태스크에서 직접 타이핑하고 TLC로 검증한다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 이 스펙이 모델링하는 시스템 동작(무엇이 상태 변수고 무엇이 액션인지)을 자신의 말로 설명할 수 있다
- [ ] #2 TypeInvariant, NoAccountWithoutGuardrails이(가) 실제로 어떤 실패 시나리오를 막는지 설명할 수 있다
<!-- AC:END -->
