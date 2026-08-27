---
id: TASK-36
title: '학습: `amazon-mq` 모듈 이해하기'
status: To Do
assignee: []
created_date: '2026-08-27 05:00'
labels:
  - module
  - amazon-mq
milestone: m-6
dependencies: []
references:
  - modules/amazon-mq
documentation:
  - 'https://docs.aws.amazon.com/amazon-mq/latest/developerguide/welcome.html'
  - >-
    https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/mq_broker
type: spike
ordinal: 71000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
핵심 개념: 레거시 브로커 호환. 공식문서를 찾아보며 아래 학습 포인트를 하나씩 이해하고, 이 모듈의 코드를 직접 읽고 타이핑하며 배운다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 AMQP/MQTT/STOMP 프로토콜
- [ ] #2 액티브/스탠바이 HA
- [ ] #3 언제 SNS/SQS 대신 이걸 써야 하는지
- [ ] #4 엔진 타입 허용값 precondition
<!-- AC:END -->
