---
id: TASK-94
title: >-
  TLA+ 명세: serverless-api — Lambda 웜/콜드 디스패치와 ConcurrencyRespected (TLC가 실제로 버그를
  찾음)
status: Done
assignee: []
created_date: '2026-08-27 06:19'
updated_date: '2026-08-27 06:19'
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
specs/serverless-api/spec.tla — 웜 인스턴스 재사용과 콜드스타트를 명세했다. 최초 버전은 DispatchCold가 warmInstances를 무한정 늘려 TypeInvariant를 위반하는 실제 버그를 TLC가 찾아냈고, warmInstances < MaxConcurrency 가드를 추가해 수정했다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [x] #1 1차 시도: TypeInvariant 위반 발견 (warmInstances가 MaxConcurrency를 초과)
- [x] #2 수정 후 TLC 검증: TypeInvariant, ConcurrencyRespected 위반 없음 (26 states, depth 7)
<!-- AC:END -->
