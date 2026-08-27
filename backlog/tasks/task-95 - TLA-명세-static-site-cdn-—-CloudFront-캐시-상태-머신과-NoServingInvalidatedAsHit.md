---
id: TASK-95
title: 'TLA+ 명세: static-site-cdn — CloudFront 캐시 상태 머신과 NoServingInvalidatedAsHit'
status: Done
assignee: []
created_date: '2026-08-27 06:19'
updated_date: '2026-08-27 06:19'
labels: []
milestone: m-16
dependencies: []
references:
  - specs/static-site-cdn/spec.tla
type: spike
ordinal: 189000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
specs/static-site-cdn/spec.tla — Miss/Hit/Stale/Invalidated 캐시 상태 전이를 명세해, 무효화된 객체가 재검증 없이 Hit로 서빙되는 일이 없음을 검증했다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [x] #1 TLC 검증: TypeInvariant, NoServingInvalidatedAsHit 위반 없음
<!-- AC:END -->
