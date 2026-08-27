---
id: TASK-32
title: '학습: `waf-shield` 모듈 이해하기'
status: To Do
assignee: []
created_date: '2026-08-27 05:00'
labels:
  - module
  - waf-shield
milestone: m-5
dependencies: []
references:
  - modules/waf-shield
documentation:
  - 'https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html'
  - 'https://docs.aws.amazon.com/waf/latest/developerguide/shield-chapter.html'
  - >-
    https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/wafv2_web_acl
type: spike
ordinal: 63000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
핵심 개념: 엣지 보안. 공식문서를 찾아보며 아래 학습 포인트를 하나씩 이해하고, 이 모듈의 코드를 직접 읽고 타이핑하며 배운다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 매니지드 룰그룹 vs 커스텀 룰
- [ ] #2 요율 제한
- [ ] #3 Shield Standard vs Advanced
- [ ] #4 scope 허용값(REGIONAL/CLOUDFRONT) precondition
<!-- AC:END -->
