---
id: TASK-86
title: 'TLA+ 명세: backup-restore-baseline — 만료 백업 복원 방지(NoRestoreFromExpired)'
status: Done
assignee: []
created_date: '2026-08-27 06:17'
updated_date: '2026-08-27 06:17'
labels: []
milestone: m-16
dependencies: []
references:
  - specs/backup-restore-baseline/spec.tla
type: spike
ordinal: 170000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
specs/backup-restore-baseline/spec.tla — 보존 기간이 지나 만료된 백업은 절대 복원될 수 없다는 제약을 명세했다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [x] #1 TLC 검증: TypeInvariant, NoRestoreFromExpired 위반 없음
- [x] #2 버그 시나리오(RestoreFromExpired)를 주석으로 남겨 대조
<!-- AC:END -->
