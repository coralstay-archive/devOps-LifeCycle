---
id: TASK-22
title: '학습: `eventbridge` 모듈 이해하기'
status: To Do
assignee: []
created_date: '2026-08-27 04:59'
labels:
  - module
  - eventbridge
milestone: m-3
dependencies: []
references:
  - modules/eventbridge
documentation:
  - 'https://docs.aws.amazon.com/eventbridge/latest/userguide/eb-what-is.html'
  - >-
    https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule
type: spike
ordinal: 43000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
핵심 개념: 이벤트 라우팅. 공식문서를 찾아보며 아래 학습 포인트를 하나씩 이해하고, 이 모듈의 코드를 직접 읽고 타이핑하며 배운다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 이벤트 패턴 매칭
- [ ] #2 스케줄 vs 이벤트 기반 트리거
- [ ] #3 크로스계정 버스
- [ ] #4 schedule_expression과 event_pattern의 XOR 관계를 precondition으로 표현하기
<!-- AC:END -->
