---
id: TASK-70
title: 'TLA+ 명세: data-warehouse — Redshift COPY 트랜잭션 원자성과 AllOrNothingCommit'
status: Done
assignee: []
created_date: '2026-08-27 06:16'
updated_date: '2026-08-27 06:16'
labels: []
milestone: m-16
dependencies: []
references:
  - specs/data-warehouse/spec.tla
type: spike
ordinal: 138000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
specs/data-warehouse/spec.tla — 스테이징된 행 수(staged)와 커밋된 행 수(committed)의 관계로 COPY 트랜잭션의 all-or-nothing 원자성을 명세했다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [x] #1 TLC 검증: TypeInvariant, AllOrNothingCommit 위반 없음
- [x] #2 CHECK_DEADLOCK FALSE 적용
<!-- AC:END -->
