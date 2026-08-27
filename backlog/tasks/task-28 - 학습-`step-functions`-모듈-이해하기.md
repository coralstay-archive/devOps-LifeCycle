---
id: TASK-28
title: '학습: `step-functions` 모듈 이해하기'
status: To Do
assignee: []
created_date: '2026-08-27 04:59'
labels:
  - module
  - step-functions
milestone: m-4
dependencies: []
references:
  - modules/step-functions
documentation:
  - 'https://docs.aws.amazon.com/step-functions/latest/dg/welcome.html'
  - >-
    https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sfn_state_machine
type: spike
ordinal: 55000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
핵심 개념: 워크플로 오케스트레이션. 공식문서를 찾아보며 아래 학습 포인트를 하나씩 이해하고, 이 모듈의 코드를 직접 읽고 타이핑하며 배운다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 Standard vs Express
- [ ] #2 상태 종류(Task/Choice/Parallel)
- [ ] #3 에러 처리/재시도
- [ ] #4 definition이 유효 JSON인지 precondition (can(jsondecode(...)) 패턴)
<!-- AC:END -->
