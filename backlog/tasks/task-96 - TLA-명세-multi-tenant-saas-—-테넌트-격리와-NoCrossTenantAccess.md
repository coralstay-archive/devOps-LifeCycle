---
id: TASK-96
title: 'TLA+ 명세: multi-tenant-saas — 테넌트 격리와 NoCrossTenantAccess'
status: Done
assignee: []
created_date: '2026-08-27 06:19'
updated_date: '2026-08-27 06:20'
labels: []
milestone: m-16
dependencies: []
references:
  - specs/multi-tenant-saas/spec.tla
type: spike
ordinal: 191000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
specs/multi-tenant-saas/spec.tla — '테넌트 A가 테넌트 B의 데이터를 절대 못 본다'는, Terraform으로는 표현할 수 없는 애플리케이션 레벨 격리 속성을 명세했다. .cfg에서 model value 선언(t1=t1 등) 누락으로 한 번 실패한 뒤 수정했다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [x] #1 1차 시도: .cfg의 model value 선언 누락으로 TLC 설정 오류 발생
- [x] #2 수정 후 TLC 검증: TypeInvariant, NoCrossTenantAccess 위반 없음
<!-- AC:END -->
