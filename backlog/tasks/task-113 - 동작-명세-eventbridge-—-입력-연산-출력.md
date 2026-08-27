---
id: TASK-113
title: '동작 명세: eventbridge — 입력/연산/출력'
status: To Do
assignee: []
created_date: '2026-08-27 14:27'
updated_date: '2026-08-27 14:30'
labels: []
milestone: m-16
dependencies: []
references:
  - specs/modules/eventbridge/spec.tla
documentation:
  - modules/eventbridge/README.md
type: spike
ordinal: 255000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
specs/modules/eventbridge/spec.tla — main.tf가 이미 강제하는 "schedule_expression과 event_pattern 중 정확히 하나만"이라는 XOR 제약을 사전조건으로 다시 표현하고, target_is_lambda가 켜졌을 때만 Lambda invoke 권한이 부여된다는 분기를 후행조건으로 검증한다.

공식문서를 찾아보며 왜 이런 동작이 실제 AWS 서비스의 제약에 대응하는지 이해한 뒤, 아래 페어링된 실습 태스크에서 직접 타이핑하고 TLC로 검증한다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 이 모듈의 입력(variables.tf)과 연산(main.tf가 호출하는 AWS API), 출력(outputs.tf)의 관계를 자신의 말로 설명할 수 있다
- [ ] #2 Postcondition이 실제로 어떤 실패 시나리오를 막는지 설명할 수 있다
<!-- AC:END -->
