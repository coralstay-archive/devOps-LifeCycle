---
id: TASK-16
title: '학습: `secrets-manager` 모듈 이해하기'
status: To Do
assignee: []
created_date: '2026-08-27 04:58'
labels:
  - module
  - secrets-manager
milestone: m-2
dependencies: []
references:
  - modules/secrets-manager
documentation:
  - 'https://docs.aws.amazon.com/secretsmanager/latest/userguide/intro.html'
  - >-
    https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret
type: spike
ordinal: 31000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
핵심 개념: 시크릿 저장. 공식문서를 찾아보며 아래 학습 포인트를 하나씩 이해하고, 이 모듈의 코드를 직접 읽고 타이핑하며 배운다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 로테이션 Lambda 패턴
- [ ] #2 Parameter Store와의 차이
- [ ] #3 버전 관리
- [ ] #4 시크릿 ARN 형태를 postcondition으로 검증하기
<!-- AC:END -->
