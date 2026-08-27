---
id: TASK-35
title: '학습: `vpc-endpoints` 모듈 이해하기'
status: To Do
assignee: []
created_date: '2026-08-27 05:00'
labels:
  - module
  - vpc-endpoints
milestone: m-5
dependencies: []
references:
  - modules/vpc-endpoints
documentation:
  - 'https://docs.aws.amazon.com/vpc/latest/privatelink/what-is-privatelink.html'
  - >-
    https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint
type: spike
ordinal: 69000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
핵심 개념: 프라이빗 연결. 공식문서를 찾아보며 아래 학습 포인트를 하나씩 이해하고, 이 모듈의 코드를 직접 읽고 타이핑하며 배운다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 게이트웨이 vs 인터페이스 엔드포인트
- [ ] #2 Private DNS
- [ ] #3 NAT 대비 비용
- [ ] #4 라우트테이블 미연결 상태를 precondition으로 막기
<!-- AC:END -->
