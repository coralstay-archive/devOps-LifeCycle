---
id: TASK-15
title: '학습: `kms` 모듈 이해하기'
status: To Do
assignee: []
created_date: '2026-08-27 04:58'
labels:
  - module
  - kms
milestone: m-2
dependencies: []
references:
  - modules/kms
documentation:
  - 'https://docs.aws.amazon.com/kms/latest/developerguide/overview.html'
  - >-
    https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key
type: spike
ordinal: 29000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
핵심 개념: 암호화 키 관리. 공식문서를 찾아보며 아래 학습 포인트를 하나씩 이해하고, 이 모듈의 코드를 직접 읽고 타이핑하며 배운다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 키 정책 vs IAM 정책
- [ ] #2 자동 로테이션
- [ ] #3 대칭/비대칭 키
- [ ] #4 크로스계정 키 공유
- [ ] #5 삭제 대기기간 7~30일 범위라는 실제 KMS 제약을 precondition으로 표현하기
<!-- AC:END -->
