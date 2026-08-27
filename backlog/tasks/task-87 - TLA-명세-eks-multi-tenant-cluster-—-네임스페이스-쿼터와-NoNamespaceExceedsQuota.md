---
id: TASK-87
title: 'TLA+ 명세: eks-multi-tenant-cluster — 네임스페이스 쿼터와 NoNamespaceExceedsQuota'
status: Done
assignee: []
created_date: '2026-08-27 06:17'
updated_date: '2026-08-27 06:17'
labels: []
milestone: m-16
dependencies: []
references:
  - specs/eks-multi-tenant-cluster/spec.tla
type: spike
ordinal: 172000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
specs/eks-multi-tenant-cluster/spec.tla — 어떤 네임스페이스도 ResourceQuota를 넘어 자원을 점유할 수 없다는 멀티 테넌트 격리를 함수 업데이트(EXCEPT)로 명세했다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [x] #1 TLC 검증: TypeInvariant, NoNamespaceExceedsQuota 위반 없음
- [x] #2 CHECK_DEADLOCK FALSE 적용
<!-- AC:END -->
