---
id: TASK-72
title: 'TLA+ 명세: etl-batch — Step Functions 재시도 상태 머신과 BoundedRetries'
status: Done
assignee: []
created_date: '2026-08-27 06:16'
updated_date: '2026-08-27 06:16'
labels: []
milestone: m-16
dependencies: []
references:
  - specs/etl-batch/spec.tla
type: spike
ordinal: 142000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
specs/etl-batch/spec.tla — Step Functions의 Retry 필드가 보장하는 '최대 재시도 후 확정 실패' 동작을 상태 머신으로 명세했다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [x] #1 TLC 검증: TypeInvariant, BoundedRetries 위반 없음
- [x] #2 CHECK_DEADLOCK FALSE 적용
<!-- AC:END -->
