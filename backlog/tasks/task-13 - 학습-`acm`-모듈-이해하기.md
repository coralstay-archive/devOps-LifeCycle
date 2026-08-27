---
id: TASK-13
title: '학습: `acm` 모듈 이해하기'
status: To Do
assignee: []
created_date: '2026-08-27 04:58'
labels:
  - module
  - acm
milestone: m-2
dependencies: []
references:
  - modules/acm
documentation:
  - 'https://docs.aws.amazon.com/acm/latest/userguide/acm-overview.html'
  - >-
    https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate
type: spike
ordinal: 25000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
핵심 개념: TLS 인증서. 공식문서를 찾아보며 아래 학습 포인트를 하나씩 이해하고, 이 모듈의 코드를 직접 읽고 타이핑하며 배운다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 DNS 검증 흐름
- [ ] #2 자동 갱신
- [ ] #3 CloudFront용 인증서는 반드시 us-east-1이어야 하는 이유
- [ ] #4 SAN에 도메인 중복 방지 precondition
<!-- AC:END -->
