---
id: TASK-4
title: '학습: `iam` 모듈 이해하기'
status: To Do
assignee: []
created_date: '2026-08-27 04:57'
labels:
  - module
  - iam
milestone: m-0
dependencies: []
references:
  - modules/iam
documentation:
  - 'https://docs.aws.amazon.com/IAM/latest/UserGuide/introduction.html'
  - 'https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles.html'
  - >-
    https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role
  - >-
    https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document
type: spike
ordinal: 7000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
핵심 개념: 범용 IAM 역할. 공식문서를 찾아보며 아래 학습 포인트를 하나씩 이해하고, 이 모듈의 코드를 직접 읽고 타이핑하며 배운다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 신뢰정책(trust policy) vs 권한정책(permission policy) 구분
- [ ] #2 managed vs inline policy 트레이드오프
- [ ] #3 최소권한 원칙
- [ ] #4 assume_role_services 최소 1개 precondition
<!-- AC:END -->
