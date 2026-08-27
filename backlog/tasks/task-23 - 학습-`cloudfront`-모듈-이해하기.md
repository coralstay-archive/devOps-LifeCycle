---
id: TASK-23
title: '학습: `cloudfront` 모듈 이해하기'
status: To Do
assignee: []
created_date: '2026-08-27 04:59'
labels:
  - module
  - cloudfront
milestone: m-3
dependencies: []
references:
  - modules/cloudfront
documentation:
  - >-
    https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/Introduction.html
  - >-
    https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_distribution
type: spike
ordinal: 45000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
핵심 개념: CDN. 공식문서를 찾아보며 아래 학습 포인트를 하나씩 이해하고, 이 모듈의 코드를 직접 읽고 타이핑하며 배운다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 OAC vs (구)OAI
- [ ] #2 캐시 정책/무효화
- [ ] #3 Lambda@Edge/CloudFront Functions
- [ ] #4 인증서 있는데 alias 없는 모순 상태를 precondition으로 막기
<!-- AC:END -->
