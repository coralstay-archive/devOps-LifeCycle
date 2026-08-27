---
id: TASK-67
title: 'TLA+ 명세: standard-web — ALB 헬스체크 상태 머신과 NoResurrection 불변식'
status: To Do
assignee: []
created_date: '2026-08-27 06:13'
updated_date: '2026-08-27 06:43'
labels: []
milestone: m-16
dependencies: []
references:
  - specs/standard-web/spec.tla
type: spike
ordinal: 133000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
specs/standard-web/spec.tla — ALB 타겟의 헬스체크 상태 전이(Pending/Healthy/Unhealthy/Terminated)를 명세하고, ghost 변수 hadResurrection으로 'Terminated는 절대 Healthy로 되돌아가지 않는다'는 안전 속성을 TLC로 검증한다.

공식문서를 찾아보며 왜 이런 제약이 실제 AWS 서비스의 동작에 대응하는지 이해한 뒤, 아래 페어링된 실습 태스크에서 직접 타이핑하고 TLC로 검증한다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 이 스펙이 모델링하는 시스템 동작(무엇이 상태 변수고 무엇이 액션인지)을 자신의 말로 설명할 수 있다
- [ ] #2 TypeInvariant, NoResurrection이(가) 실제로 어떤 실패 시나리오를 막는지 설명할 수 있다
<!-- AC:END -->
