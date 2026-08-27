---
id: TASK-17
title: '학습: `ecr` 모듈 이해하기'
status: To Do
assignee: []
created_date: '2026-08-27 04:58'
labels:
  - module
  - ecr
milestone: m-2
dependencies: []
references:
  - modules/ecr
documentation:
  - 'https://docs.aws.amazon.com/AmazonECR/latest/userguide/what-is-ecr.html'
  - >-
    https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository
type: spike
ordinal: 33000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
핵심 개념: 컨테이너 레지스트리. 공식문서를 찾아보며 아래 학습 포인트를 하나씩 이해하고, 이 모듈의 코드를 직접 읽고 타이핑하며 배운다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 이미지 스캔
- [ ] #2 태그 불변성
- [ ] #3 수명주기 정책
- [ ] #4 크로스계정 풀 권한
- [ ] #5 만료일수 최소값 precondition
<!-- AC:END -->
