---
id: TASK-90
title: 'TLA+ 명세: canary-deployment — 실패 후 승격 금지(NoPromotionAfterFailure)'
status: Done
assignee: []
created_date: '2026-08-27 06:18'
updated_date: '2026-08-27 06:18'
labels: []
milestone: m-16
dependencies: []
references:
  - specs/canary-deployment/spec.tla
type: spike
ordinal: 178000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
specs/canary-deployment/spec.tla — 실패가 감지된 상태에서는 canary 가중치가 절대 늘지 않는다는 것을 ghost 변수(promotedAfterFailure)로 명세했다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [x] #1 TLC 검증: TypeInvariant, NoPromotionAfterFailure 위반 없음
- [x] #2 CHECK_DEADLOCK FALSE 적용
<!-- AC:END -->
