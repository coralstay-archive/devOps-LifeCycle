---
id: TASK-119
title: '동작 명세: msk-kafka — 입력/연산/출력'
status: To Do
assignee: []
created_date: '2026-08-27 14:28'
updated_date: '2026-08-27 14:30'
labels: []
milestone: m-16
dependencies: []
references:
  - specs/modules/msk-kafka/spec.tla
documentation:
  - modules/msk-kafka/README.md
type: spike
ordinal: 267000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
specs/modules/msk-kafka/spec.tla — MSK API 자체가 브로커 수를 AZ 개수의 배수로 강제한다(브로커를 AZ마다 고르게 분산 배치해야 하므로) — main.tf의 lifecycle.precondition과 동일한 제약을 사전조건으로 다시 표현한다.

공식문서를 찾아보며 왜 이런 동작이 실제 AWS 서비스의 제약에 대응하는지 이해한 뒤, 아래 페어링된 실습 태스크에서 직접 타이핑하고 TLC로 검증한다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 이 모듈의 입력(variables.tf)과 연산(main.tf가 호출하는 AWS API), 출력(outputs.tf)의 관계를 자신의 말로 설명할 수 있다
- [ ] #2 Postcondition이 실제로 어떤 실패 시나리오를 막는지 설명할 수 있다
<!-- AC:END -->
