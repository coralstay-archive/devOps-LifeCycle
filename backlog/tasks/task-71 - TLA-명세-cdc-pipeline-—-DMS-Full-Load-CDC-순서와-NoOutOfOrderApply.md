---
id: TASK-71
title: 'TLA+ 명세: cdc-pipeline — DMS Full Load -> CDC 순서와 NoOutOfOrderApply'
status: Done
assignee: []
created_date: '2026-08-27 06:16'
updated_date: '2026-08-27 06:16'
labels: []
milestone: m-16
dependencies: []
references:
  - specs/cdc-pipeline/spec.tla
type: spike
ordinal: 140000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
specs/cdc-pipeline/spec.tla — Full Load가 끝나기 전에는 CDC 변경분이 타겟에 적용될 수 없다는 DMS의 2단계 복제 순서를 명세했다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [x] #1 TLC 검증: TypeInvariant, NoOutOfOrderApply 위반 없음
<!-- AC:END -->
