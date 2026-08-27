---
id: TASK-84
title: 'TLA+ 명세: multi-region-active-active — 비동기 복제와 EventuallyFullyReplicated'
status: Done
assignee: []
created_date: '2026-08-27 06:17'
updated_date: '2026-08-27 06:17'
labels: []
milestone: m-16
dependencies: []
references:
  - specs/multi-region-active-active/spec.tla
type: spike
ordinal: 166000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
specs/multi-region-active-active/spec.tla — 리전 간 비동기 복제 지연을 허용하면서도, 쓰인 데이터는 결국 다른 리전에 복제된다는 최종적 일관성을 leads-to(~>) 연산자와 WF 공정성으로 검증했다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [x] #1 TLC 검증: TypeInvariant, NoOverReplication 위반 없음
- [x] #2 PROPERTY EventuallyFullyReplicated 검증 통과
<!-- AC:END -->
