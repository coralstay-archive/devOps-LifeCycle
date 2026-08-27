---
id: TASK-128
title: '동작 명세: sns-sqs — 입력/연산/출력'
status: To Do
assignee: []
created_date: '2026-08-27 14:29'
updated_date: '2026-08-27 14:30'
labels: []
milestone: m-16
dependencies: []
references:
  - specs/modules/sns-sqs/spec.tla
documentation:
  - modules/sns-sqs/README.md
type: spike
ordinal: 285000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
specs/modules/sns-sqs/spec.tla — 핵심 동작은 main.tf 주석이 직접 짚는 바로 그것 — SQS 큐 정책의 ArnEquals 조건이 "이 특정 토픽"만 허용해야 하고, 다른 SNS 토픽은 이 큐에 못 쓰게 막아야 한다는 것. 와일드카드로 느슨해지면 계정 내 어떤 SNS 토픽이든 이 큐에 메시지를 넣을 수 있게 되는 보안 사고다.

공식문서를 찾아보며 왜 이런 동작이 실제 AWS 서비스의 제약에 대응하는지 이해한 뒤, 아래 페어링된 실습 태스크에서 직접 타이핑하고 TLC로 검증한다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 이 모듈의 입력(variables.tf)과 연산(main.tf가 호출하는 AWS API), 출력(outputs.tf)의 관계를 자신의 말로 설명할 수 있다
- [ ] #2 Postcondition이 실제로 어떤 실패 시나리오를 막는지 설명할 수 있다
<!-- AC:END -->
