---
id: TASK-82
title: 'TLA+ 명세: private-vpc-only — 인터넷 경로 부재(NoInternetRoute) 불변식'
status: Done
assignee: []
created_date: '2026-08-27 06:17'
updated_date: '2026-08-27 06:17'
labels: []
milestone: m-16
dependencies: []
references:
  - specs/private-vpc-only/spec.tla
type: spike
ordinal: 162000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
specs/private-vpc-only/spec.tla — 어떤 라우팅 테이블도 인터넷 게이트웨이로 가는 경로를 갖지 않는다는 정적 불변식을 명세했다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [x] #1 TLC 검증: TypeInvariant, NoInternetRoute 위반 없음
- [x] #2 버그 시나리오(AddInternetRoute)를 주석으로 남겨 대조
<!-- AC:END -->
