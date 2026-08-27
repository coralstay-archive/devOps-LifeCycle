---
id: TASK-94
title: >-
  TLA+ 명세: serverless-api — Lambda 웜/콜드 디스패치와 ConcurrencyRespected (TLC가 실제로 버그를
  찾음)
status: To Do
assignee: []
created_date: '2026-08-27 06:19'
updated_date: '2026-08-27 06:44'
labels: []
milestone: m-16
dependencies: []
references:
  - specs/serverless-api/spec.tla
type: spike
ordinal: 187000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
specs/serverless-api/spec.tla — 웜 인스턴스 재사용과 콜드스타트를 먼저 가드 없이 명세해본다. 이렇게 하면 DispatchCold가 warmInstances를 무한정 늘려 TypeInvariant를 위반하는 실제 버그를 TLC가 찾아낸다 — 왜 그런지 이해한 뒤, warmInstances < MaxConcurrency 가드를 추가해 수정하고 재검증한다.

공식문서를 찾아보며 왜 이런 제약이 실제 AWS 서비스의 동작에 대응하는지 이해한 뒤, 아래 페어링된 실습 태스크에서 직접 타이핑하고 TLC로 검증한다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 이 스펙이 모델링하는 시스템 동작(무엇이 상태 변수고 무엇이 액션인지)을 자신의 말로 설명할 수 있다
- [ ] #2 TypeInvariant, ConcurrencyRespected이(가) 실제로 어떤 실패 시나리오를 막는지 설명할 수 있다
- [ ] #3 이 스펙을 만드는 과정에서 TLC가 실제로 찾아낸 문제가 무엇이었고 어떻게 고쳤는지 설명할 수 있다
<!-- AC:END -->
