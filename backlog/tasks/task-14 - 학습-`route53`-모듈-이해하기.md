---
id: TASK-14
title: '학습: `route53` 모듈 이해하기'
status: To Do
assignee: []
created_date: '2026-08-27 04:58'
labels:
  - module
  - route53
milestone: m-2
dependencies: []
references:
  - modules/route53
documentation:
  - 'https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/Welcome.html'
  - >-
    https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_zone
  - >-
    https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record
type: spike
ordinal: 27000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
핵심 개념: DNS. 공식문서를 찾아보며 아래 학습 포인트를 하나씩 이해하고, 이 모듈의 코드를 직접 읽고 타이핑하며 배운다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 호스팅존 vs 레코드
- [ ] #2 라우팅 정책(가중치/레이턴시/페일오버)
- [ ] #3 헬스체크
- [ ] #4 레코드별 TTL 양수 precondition (for_each 리소스에 precondition 적용하는 법)
<!-- AC:END -->
