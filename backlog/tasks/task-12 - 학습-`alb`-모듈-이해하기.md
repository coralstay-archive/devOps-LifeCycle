---
id: TASK-12
title: '학습: `alb` 모듈 이해하기'
status: To Do
assignee: []
created_date: '2026-08-27 04:58'
labels:
  - module
  - alb
milestone: m-2
dependencies: []
references:
  - modules/alb
documentation:
  - >-
    https://docs.aws.amazon.com/elasticloadbalancing/latest/application/introduction.html
  - >-
    https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb
  - >-
    https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group
  - >-
    https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener
type: spike
ordinal: 23000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
핵심 개념: L7 로드밸런서. 공식문서를 찾아보며 아래 학습 포인트를 하나씩 이해하고, 이 모듈의 코드를 직접 읽고 타이핑하며 배운다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 리스너/타겟그룹/헬스체크
- [ ] #2 HTTP→HTTPS 리다이렉트
- [ ] #3 리스너 규칙으로 다중 서비스 라우팅
- [ ] #4 ALB는 최소 2개 AZ가 필요하다는 실제 API 제약을 precondition으로 표현하기
<!-- AC:END -->
