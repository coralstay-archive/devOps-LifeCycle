---
id: TASK-24
title: '학습: `glue` 모듈 이해하기'
status: To Do
assignee: []
created_date: '2026-08-27 04:59'
labels:
  - module
  - glue
milestone: m-4
dependencies: []
references:
  - modules/glue
documentation:
  - 'https://docs.aws.amazon.com/glue/latest/dg/what-is-glue.html'
  - >-
    https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/glue_crawler
  - >-
    https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/glue_catalog_database
type: spike
ordinal: 47000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
핵심 개념: ETL/카탈로그. 공식문서를 찾아보며 아래 학습 포인트를 하나씩 이해하고, 이 모듈의 코드를 직접 읽고 타이핑하며 배운다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 크롤러 vs ETL 잡
- [ ] #2 데이터 카탈로그
- [ ] #3 파티션 프로젝션
- [ ] #4 카탈로그 DB 이름 규칙(하이픈 불가)을 precondition으로 표현하기
<!-- AC:END -->
