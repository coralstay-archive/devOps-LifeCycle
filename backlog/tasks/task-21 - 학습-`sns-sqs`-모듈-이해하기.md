---
id: TASK-21
title: '학습: `sns-sqs` 모듈 이해하기'
status: To Do
assignee: []
created_date: '2026-08-27 04:59'
labels:
  - module
  - sns-sqs
milestone: m-3
dependencies: []
references:
  - modules/sns-sqs
documentation:
  - 'https://docs.aws.amazon.com/sns/latest/dg/welcome.html'
  - >-
    https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/welcome.html
  - >-
    https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic
  - >-
    https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue
type: spike
ordinal: 41000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
핵심 개념: 메시징 기본 단위. 공식문서를 찾아보며 아래 학습 포인트를 하나씩 이해하고, 이 모듈의 코드를 직접 읽고 타이핑하며 배운다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 팬아웃 패턴
- [ ] #2 DLQ/재시도
- [ ] #3 FIFO 큐
- [ ] #4 가시성 타임아웃
- [ ] #5 큐 ARN 형태를 postcondition으로 검증하기
<!-- AC:END -->
