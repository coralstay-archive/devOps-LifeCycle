---
id: TASK-1
title: '학습: `vpc` 모듈 이해하기'
status: To Do
assignee: []
created_date: '2026-08-27 04:57'
labels:
  - module
  - vpc
milestone: m-0
dependencies: []
references:
  - modules/vpc
documentation:
  - 'https://docs.aws.amazon.com/vpc/latest/userguide/what-is-amazon-vpc.html'
  - >-
    https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc
  - >-
    https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet
  - >-
    https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway
type: spike
ordinal: 1000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
핵심 개념: 네트워크 격리 단위. 공식문서를 찾아보며 아래 학습 포인트를 하나씩 이해하고, 이 모듈의 코드를 직접 읽고 타이핑하며 배운다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 CIDR 설계
- [ ] #2 public/private 서브넷 계층
- [ ] #3 AZ당 NAT 비용/이중화 트레이드오프
- [ ] #4 VPC 엔드포인트
- [ ] #5 Flow Logs
- [ ] #6 one subnet per AZ 불변식을 precondition으로 표현하기
<!-- AC:END -->
