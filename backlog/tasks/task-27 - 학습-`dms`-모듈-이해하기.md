---
id: TASK-27
title: '학습: `dms` 모듈 이해하기'
status: To Do
assignee: []
created_date: '2026-08-27 04:59'
labels:
  - module
  - dms
milestone: m-4
dependencies: []
references:
  - modules/dms
documentation:
  - 'https://docs.aws.amazon.com/dms/latest/userguide/'
  - 'https://docs.aws.amazon.com/dms/latest/userguide/CHAP_BestPractices.html'
  - >-
    https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dms_replication_instance
  - >-
    https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dms_replication_task
type: spike
ordinal: 53000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
핵심 개념: DB 마이그레이션/CDC. 공식문서를 찾아보며 아래 학습 포인트를 하나씩 이해하고, 이 모듈의 코드를 직접 읽고 타이핑하며 배운다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 full-load vs full-load-and-cdc
- [ ] #2 테이블 매핑 규칙
- [ ] #3 엔드포인트 인증(Secrets Manager 연동)
- [ ] #4 포트 범위 유효성 precondition
<!-- AC:END -->
