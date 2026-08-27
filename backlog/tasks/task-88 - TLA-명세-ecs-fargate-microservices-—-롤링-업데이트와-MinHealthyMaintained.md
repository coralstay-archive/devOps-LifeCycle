---
id: TASK-88
title: 'TLA+ 명세: ecs-fargate-microservices — 롤링 업데이트와 MinHealthyMaintained'
status: Done
assignee: []
created_date: '2026-08-27 06:17'
updated_date: '2026-08-27 06:17'
labels: []
milestone: m-16
dependencies: []
references:
  - specs/ecs-fargate-microservices/spec.tla
type: spike
ordinal: 174000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
specs/ecs-fargate-microservices/spec.tla — minimum_healthy_percent 가드가 배포 중에도 healthy 태스크 수를 최소치 이상으로 유지시킨다는 것을 명세했다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [x] #1 TLC 검증: TypeInvariant, MinHealthyMaintained 위반 없음
- [x] #2 CHECK_DEADLOCK FALSE 적용
<!-- AC:END -->
