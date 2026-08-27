---
id: TASK-91
title: >-
  TLA+ 명세: observability-only-baseline — 에러 버짓 소진 알람과
  AlwaysBurningEventuallyFires (TLC가 실제로 반례를 찾음)
status: To Do
assignee: []
created_date: '2026-08-27 06:18'
updated_date: '2026-08-27 08:58'
labels: []
milestone: m-16
dependencies: []
references:
  - specs/observability-only-baseline/spec.tla
type: spike
ordinal: 180000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
specs/observability-only-baseline/spec.tla — 'burning이 한 번이라도 시작되면 결국 알람이 울린다'를 WF_vars(AlarmFires)만으로 먼저 명세해본다. 이렇게 하면 TLC가 'burning이 알람 평가 전에 순간적으로 꺼지는' flapping 반례를 실제로 찾아낸다. 전제를 '[]burning => <>Firing'(계속 지속되는 burning)으로 고쳐도, burning이 Init에서 FALSE로 시작하는 한 []burning은 모든 behavior에서 이미 거짓이라 이 속성 전체가 공허하게 항상 참이 되어버리는 두 번째 문제가 있다 — 최종적으로는 '(<>[]burning) => (<>Firing)'(어느 시점부터는 계속 burning이면)으로 고쳐야 실제로 뭔가를 검증하는 속성이 된다.

공식문서를 찾아보며 왜 이런 제약이 실제 AWS 서비스의 동작에 대응하는지 이해한 뒤, 아래 페어링된 실습 태스크에서 직접 타이핑하고 TLC로 검증한다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 이 스펙이 모델링하는 시스템 동작(무엇이 상태 변수고 무엇이 액션인지)을 자신의 말로 설명할 수 있다
- [ ] #2 TypeInvariant, AlwaysBurningEventuallyFires이(가) 실제로 어떤 실패 시나리오를 막는지 설명할 수 있다
- [ ] #3 이 스펙을 만드는 과정에서 TLC가 실제로 찾아낸 문제가 무엇이었고 어떻게 고쳤는지 설명할 수 있다
<!-- AC:END -->
