---
id: TASK-95
title: 'TLA+ 명세: static-site-cdn — CloudFront 캐시 상태 머신과 NoServingInvalidatedAsHit'
status: To Do
assignee: []
created_date: '2026-08-27 06:19'
updated_date: '2026-08-27 06:44'
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
specs/static-site-cdn/spec.tla — Miss/Hit/Stale/Invalidated 캐시 상태 전이를 명세해, 무효화된 객체가 재검증 없이 Hit로 서빙되는 일이 없음을 TLC로 검증한다.

공식문서를 찾아보며 왜 이런 제약이 실제 AWS 서비스의 동작에 대응하는지 이해한 뒤, 아래 페어링된 실습 태스크에서 직접 타이핑하고 TLC로 검증한다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 이 스펙이 모델링하는 시스템 동작(무엇이 상태 변수고 무엇이 액션인지)을 자신의 말로 설명할 수 있다
- [ ] #2 TypeInvariant, NoServingInvalidatedAsHit이(가) 실제로 어떤 실패 시나리오를 막는지 설명할 수 있다
- [ ] #3 주석 처리된 ServeStaleFromInvalidated 액션이 왜 Next에 포함되면 안 되는지, 포함하면 어떤 불변식이 깨질지 설명할 수 있다
<!-- AC:END -->
