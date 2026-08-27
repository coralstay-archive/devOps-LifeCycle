---
id: TASK-79
title: 'TLA+ 명세: ml-realtime-inference — blue/green 무중단 갱신과 NeverZeroCapacity'
status: To Do
assignee: []
created_date: '2026-08-27 06:16'
updated_date: '2026-08-27 06:43'
labels: []
milestone: m-16
dependencies: []
references:
  - specs/ml-realtime-inference/spec.tla
type: spike
ordinal: 156000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
specs/ml-realtime-inference/spec.tla — green 인스턴스가 뜬 뒤에야 blue를 내리는 순서 제약으로, 서빙 용량이 0이 되는 순간이 없음을 명세하고 TLC로 검증한다.

공식문서를 찾아보며 왜 이런 제약이 실제 AWS 서비스의 동작에 대응하는지 이해한 뒤, 아래 페어링된 실습 태스크에서 직접 타이핑하고 TLC로 검증한다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 이 스펙이 모델링하는 시스템 동작(무엇이 상태 변수고 무엇이 액션인지)을 자신의 말로 설명할 수 있다
- [ ] #2 TypeInvariant, NeverZeroCapacity이(가) 실제로 어떤 실패 시나리오를 막는지 설명할 수 있다
<!-- AC:END -->
