---
id: TASK-9
title: '학습: `msk-kafka` 모듈 이해하기'
status: To Do
assignee: []
created_date: '2026-08-27 04:58'
labels:
  - module
  - msk-kafka
milestone: m-1
dependencies: []
references:
  - modules/msk-kafka
documentation:
  - 'https://docs.aws.amazon.com/msk/latest/developerguide/what-is-msk.html'
  - >-
    https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/msk_cluster
type: spike
ordinal: 17000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
핵심 개념: 이벤트 스트리밍. 공식문서를 찾아보며 아래 학습 포인트를 하나씩 이해하고, 이 모듈의 코드를 직접 읽고 타이핑하며 배운다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 파티션/브로커 설계
- [ ] #2 컨슈머 그룹과 오프셋
- [ ] #3 MSK Serverless vs Provisioned
- [ ] #4 IAM/SASL 인증
- [ ] #5 브로커 수가 AZ 수의 배수여야 하는 실제 MSK 제약을 precondition으로 표현하기
<!-- AC:END -->
