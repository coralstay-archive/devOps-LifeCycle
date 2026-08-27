---
id: TASK-25
title: '학습: `athena` 모듈 이해하기'
status: To Do
assignee: []
created_date: '2026-08-27 04:59'
labels:
  - module
  - athena
milestone: m-4
dependencies: []
references:
  - modules/athena
documentation:
  - 'https://docs.aws.amazon.com/athena/latest/ug/what-is.html'
  - >-
    https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/athena_workgroup
type: spike
ordinal: 49000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
핵심 개념: 서버리스 쿼리. 공식문서를 찾아보며 아래 학습 포인트를 하나씩 이해하고, 이 모듈의 코드를 직접 읽고 타이핑하며 배운다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 워크그룹별 비용 제어
- [ ] #2 파티셔닝으로 스캔량 절감
- [ ] #3 CTAS
- [ ] #4 출력 위치가 s3:// URI인지 precondition
<!-- AC:END -->
