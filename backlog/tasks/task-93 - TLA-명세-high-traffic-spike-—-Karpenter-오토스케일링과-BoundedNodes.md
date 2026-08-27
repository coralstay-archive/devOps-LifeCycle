---
id: TASK-93
title: 'TLA+ 명세: high-traffic-spike — Karpenter 오토스케일링과 BoundedNodes'
status: To Do
assignee: []
created_date: '2026-08-27 06:19'
updated_date: '2026-08-27 06:44'
labels: []
milestone: m-16
dependencies: []
references:
  - specs/high-traffic-spike/spec.tla
type: spike
ordinal: 185000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
specs/high-traffic-spike/spec.tla — 부하(load)와 노드 수(nodes)의 관계로 Karpenter 스타일 오토스케일링(ScaleUp/ScaleDown)을 명세하고, 노드 수가 MaxNodes를 절대 넘지 않음을 TLC로 검증한다.

공식문서를 찾아보며 왜 이런 제약이 실제 AWS 서비스의 동작에 대응하는지 이해한 뒤, 아래 페어링된 실습 태스크에서 직접 타이핑하고 TLC로 검증한다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 이 스펙이 모델링하는 시스템 동작(무엇이 상태 변수고 무엇이 액션인지)을 자신의 말로 설명할 수 있다
- [ ] #2 TypeInvariant, BoundedNodes이(가) 실제로 어떤 실패 시나리오를 막는지 설명할 수 있다
<!-- AC:END -->
