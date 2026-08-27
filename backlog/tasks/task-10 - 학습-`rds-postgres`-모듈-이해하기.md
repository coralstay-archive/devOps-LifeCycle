---
id: TASK-10
title: '학습: `rds-postgres` 모듈 이해하기'
status: To Do
assignee: []
created_date: '2026-08-27 04:58'
labels:
  - module
  - rds-postgres
milestone: m-1
dependencies: []
references:
  - modules/rds-postgres
documentation:
  - 'https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_PostgreSQL.html'
  - >-
    https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance
type: spike
ordinal: 19000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
핵심 개념: 관계형 DB. 공식문서를 찾아보며 아래 학습 포인트를 하나씩 이해하고, 이 모듈의 코드를 직접 읽고 타이핑하며 배운다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 Multi-AZ vs 읽기 복제본
- [ ] #2 RDS의 Secrets Manager 관리형 마스터 비밀번호
- [ ] #3 백업 보존 정책
- [ ] #4 allocated_storage 최소값(20GB) precondition
<!-- AC:END -->
