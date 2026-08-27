---
id: TASK-67
title: 'TLA+ 명세: standard-web — ALB 헬스체크 상태 머신과 NoResurrection 불변식'
status: Done
assignee: []
created_date: '2026-08-27 06:13'
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
specs/standard-web/spec.tla — ALB 타겟의 헬스체크 상태 전이(Pending/Healthy/Unhealthy/Terminated)를 명세하고, ghost 변수 hadResurrection으로 'Terminated는 절대 Healthy로 되돌아가지 않는다'는 안전 속성을 TLC로 검증했다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 spec.tla + spec.cfg 작성 완료
- [ ] #2 TLC 검증: TypeInvariant, NoResurrection 위반 없음 (7 states, depth 6)
- [ ] #3 모든 액션에 학습 주석(한국어) 포함
<!-- AC:END -->
