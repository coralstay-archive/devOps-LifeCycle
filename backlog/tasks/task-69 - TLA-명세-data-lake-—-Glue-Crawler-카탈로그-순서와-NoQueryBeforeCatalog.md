---
id: TASK-69
title: 'TLA+ 명세: data-lake — Glue Crawler/카탈로그 순서와 NoQueryBeforeCatalog'
status: Done
assignee: []
created_date: '2026-08-27 06:15'
updated_date: '2026-08-27 06:15'
labels: []
milestone: m-16
dependencies: []
references:
  - specs/data-lake/spec.tla
type: spike
ordinal: 136000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
specs/data-lake/spec.tla — Raw -> Crawling -> Cataloged -> Queried 상태 전이를 명세해, 카탈로그 등록 전에는 Athena 쿼리가 성립할 수 없음을 검증했다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [x] #1 TLC 검증: TypeInvariant, NoQueryBeforeCatalog 위반 없음
- [x] #2 버그 시나리오(QueryBeforeCatalog)를 주석으로 남겨 대조
<!-- AC:END -->
