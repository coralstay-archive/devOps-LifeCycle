---
id: TASK-19
title: '학습: `dynamodb` 모듈 이해하기'
status: To Do
assignee: []
created_date: '2026-08-27 04:59'
labels:
  - module
  - dynamodb
milestone: m-3
dependencies: []
references:
  - modules/dynamodb
documentation:
  - >-
    https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Introduction.html
  - >-
    https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table
type: spike
ordinal: 37000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
핵심 개념: 서버리스 NoSQL. 공식문서를 찾아보며 아래 학습 포인트를 하나씩 이해하고, 이 모듈의 코드를 직접 읽고 타이핑하며 배운다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 파티션 키 설계
- [ ] #2 GSI/LSI
- [ ] #3 on-demand vs provisioned
- [ ] #4 스트림
- [ ] #5 hash_key_type이 S/N/B인지 precondition
<!-- AC:END -->
