---
id: TASK-20
title: '학습: `api-gateway` 모듈 이해하기'
status: To Do
assignee: []
created_date: '2026-08-27 04:59'
labels:
  - module
  - api-gateway
milestone: m-3
dependencies: []
references:
  - modules/api-gateway
documentation:
  - 'https://docs.aws.amazon.com/apigateway/latest/developerguide/http-api.html'
  - >-
    https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apigatewayv2_api
type: spike
ordinal: 39000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
핵심 개념: API 프론트엔드. 공식문서를 찾아보며 아래 학습 포인트를 하나씩 이해하고, 이 모듈의 코드를 직접 읽고 타이핑하며 배운다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 REST API vs HTTP API 차이
- [ ] #2 프록시 통합
- [ ] #3 스로틀링/사용량 계획
- [ ] #4 route_key 형식 검증 precondition (정규식 활용)
<!-- AC:END -->
